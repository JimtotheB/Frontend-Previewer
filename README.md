#Frontend-Previewer

###A Simple static site server with live reload.

###Features

* Watches and compiles Less, Jade and Coffeescript
* Automatically includes in index.html, any .js and .css files it finds.
* Uses bower for outside frontend package management. 


###Installation

    $ git clone git@github.com:PaperElectron/Frontend-Previewer.git my-awesome-project/
    $ cd my-awesome-project
    $ npm install 
    
npm will install bower dependencies, node modules, and finally run gulp. The live preview server will start at 
http://localhost:9000 or http://server.host:9000 (if you are working in a VM or somesuch).

###gulp tasks
    
    $ gulp #default runs all of the watchers and starts the server
    $ gulp buildLess #Builds the projects Less files 
    $ gulp buildCoffee #builds the projects Coffeescript files

###Workflow

Add files to ```./assets/<coffee|jade|css>``` and they will automatically be compiled
and sent to your browser. Files in ```./server/assets/<css|js|img>``` will also be watched for changes.

###Outside dependencies

Install with bower install <package> they will be available in the ```./server/components``` directory
and can be easily added to your project by adding a line to ```./assets/jade/bower.jade``` 

This project currently installs jQuery, lodash and moment.js, feel free to edit bower.json to add or remove whatever you
want. (dont forget to edit ```./assets/jade/bower.jade``` as well.
