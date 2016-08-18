#!/bin/bash
set -e

echo KDV_TEST=$KDV_TEST
echo VCAP_APPLICATION=$VCAP_APPLICATION

echo STARTING ORION
export PATH=${PATH}:${HOME}/nodejs/node-v4.5.0-linux-x64/bin:${HOME}/node_modules/.bin
pushd node_modules/orion-duck-tape
npm start &
popd


classpathDir=${HOME}/classpath
libDir=${classpathDir}/BOOT-INF/lib
classesDir=${classpathDir}/BOOT-INF/classes
libJars=$(find ${libDir} -name '*.jar')
classpath=${classesDir}$(printf ":%s" ${libJars[@]})
mainClass=`cat ${classpathDir}/META-INF/MANIFEST.MF | grep 'Start-Class:' | awk '{print $2}' | tr -d '\r' | tr -d '\n'`

echo '==== classpath ====' 
echo $classpath
echo '==== mainClass ====' 
echo ${mainClass}
echo '==== starting java app ===='

$JAVA_HOME/bin/java \
    -Dsourceroot=${HOME}/src/main/java \
    -Dtargetroot=${classesDir} \
    -cp ${classpath} \
    ${mainClass}

# echo STARTING JAVA APP
# echo $JAVA_HOME/bin/java \
#     -Dsourceroot=${HOME}/src/main/java \
#     -Dtargetroot=${targetRoot} \
#     -Dspring.devtools.restart.additional-paths=${targetRoot} \
#     -cp classpath \
#     org.springframework.boot.loader.JarLauncher

