echo "Intalling Node.js from separate script"
nodeJsUrl=https://nodejs.org/dist/v4.5.0/node-v4.5.0-linux-x64.tar.gz
version=node-v4.5.0-linux-x64
appDir=$1
cacheDir=$2
##############################################################################################
# Node.js setup
##############################################################################################
echo ===== setting up Node.js =====
cd $cacheDir
echo "Checking if Node.js tar file is downloaded in cache " `pwd`
if [ -f node.tar.gz ]; then
    echo "Found node.js install in cache"
else
    wget $nodeJsUrl -O node.tar.gz # would be nice to use -N but it doesn't work for this url.
fi

cd ${appDir}
mkdir nodejs
cd nodejs
echo "Unzipping to " `pwd`

tar xzf ${cacheDir}/node.tar.gz
cd $version

nodeDir=`pwd`
echo "Node version: " `./bin/node -v`
echo "NPM version: " `./bin/npm -v`

cd ${appDir}
mkdir node_modules
echo "Installing Orion via npm"
#${nodeDir}/bin/npm install https://github.com/kdvolder/orion-duck-tape
${nodeDir}/bin/npm install https://github.com/aclement/orion-duck-tape

