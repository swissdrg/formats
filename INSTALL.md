#Install File

##General Settings
###Ports

```
PostgreSQL: 5432
Docker: 3000
Localhost: 300
```
###Versions

By using this versions, the application should start up fine.
```
Ubuntu: Ubuntu 16.04
PostgreSQL: 10.3
Ruby: 2.5.0
Rails: 5.1.5     
Docker: 18.03        
```

##How to install all necessary parts
Instead of writing the same thing twice, we decided to share the guides we used to set up the needed components.
These guides describes perfectly how to install: <br/> Ruby, Rails and PostgreSQL: `https://gorails.com/setup/ubuntu/16.04`
<br/>
And Docker like this: `https://docs.docker.com/install/linux/docker-ce/ubuntu/`

##How to run the Application

###With Docker
####Initial Setup
Make sure to run the following commands from the project root directory *after every time you make changes to the project setup*, such as changing the Gemfile or the Docker configuration.
Also run them the **first** time you try to start the application.
```
docker-compose build
docker-compose run web rake db:create db:seed
```
Now docker should be ready to start up:
Run the application as follows:
#### Running the application

Starting the app should be as simple as executing `docker-compose up` from the project directory.
You can then access it by navigating to `0.0.0.0:3000` in your browser.

#### Resetting the Database
Run the following commands to drop the database and seed it with new data. This will remove all entries and re-generate the database.

```
docker-compose down # Stops all instances
docker-compose run web rake db:reset # Drops all databases and creates new, seeded databases
```
In some cases you may have to run the second command a few times until it completes with no errors.

#### Seeding the Database
If you want to manually seed the database with data, such as a test user, just run
`docker-compose run web rake db:seed`

###Without Docker

####Initial Setup
Run `bundle install` to fetch and install all required dependencies. Ensure running `ruby -v` shows a version >= 2.5.0 and `rails -v` shows a version >= 5.1.5

#### Running the application
Run the application by entering `rails server` from the main project directory. Then navigate to `0.0.0.0:3000` in your browser.

#### Resetting the database
To reset the database, run `rails db:reset`. This will remove all entries and re-generate the database. Including seeding of the database

#### Seeding the database
Run `rake db:seed` from the main project directory to create a user.

##Known Problems
###Docker permission
```
Got permission denied while trying to connect to the Docker daemon socket at unix:...
```
=> Use sudo before every Docker command. This happens because Docker was installed with sudo permission and therefore has to be started like that.
###Ports already occupied
There are **two** solutions:<br/>
**1.** Kill the process which occupies the port. <br/>
    **First** run: `sudo netstat -lpn |grep :8080`, 
    this will display something like this: `tcp6       0      0 :::8080                 :::*                    LISTEN      6782/java` <br/>
    **Then** use the **number** eg. *6782* behind **Listen** to free the port with: `kill number` eg. *`kill 6782`*<br />
**2.** Change the port as shown in the **Change Port Settings** part
###Gems are missing

Just run `bundle install` and everything should work fine.

##Change Port Settings

###With Docker

Go to the **docker-compose.yml** file. There are two parts. One is for connecting the application and the other one for the Database. To change the Database port rewrite the ports **db** part. To rewrite the application port, do the same under **web**.

###Without Docker

To change the port which the application should listen to go to: `config` and open the `puma.rb` file. Somewhere in the file should be this line:  `port        ENV.fetch('PORT') { 3000 }`.
Rewrite the `3000` to any number you wish. Remember to run the application with `0.0.0.0.yourNumber`

To change the port for the Database go to: `config` and open the `databse.yml` file. Then in the **default** section you can enter something like this: 
`port: yourNumber`. Chose whatever port you want for `yourNumber`.