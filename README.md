# tools-buildpack

Expected to be used when pushing a folder containing a built boot app plus sources, push should be done from root folder. For example:

    cf push toolsdemo -p . -m 2G -b https://github.com/aclement/tools-buildpack

Then it:
- Lays out a filesystem containing the unpacked Spring Boot application with the sources alongside
- Provisions a JDK instead of a JRE because we are running compilation at runtime
- Adds the Spring Boot devtools and the 'idetools' to the application classpath
- Provisions a node environment
- Installs and launches the node variant of the Eclipse Orion IDE
- Launches the Spring Boot application


Notes on classpath additions:
- 'devtools' operates exactly the same as it does on the command line.
- 'idetools' adds a zuul proxy route to the application that forwards to the orion editor (running on CF alongside the app but on a different port). It also sets up a Java compiler ready to run for any changes made to source files.

Accessing the application:
- Visiting / will give you the application as normal
- Visiting /ide will give you an editor for the application

Upon saving in the IDE javac will run and when the class file on disk is updated, devtools will notice and restart the application.

Notes:
- using devtools the app will be going up and down as it restarts. If the CF health check runs whilst it is restarting it may think the app is dead and kill the instance entirely. Turn off the health check with `cf set-health-check andy1 none`.
