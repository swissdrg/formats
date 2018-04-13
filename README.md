# README

## Usage

### Setting Up Docker
First, install Docker and Docker-Compose on your system.

Make sure to run the following commands from the project root directory *after every time you make changes to the project setup*, such as changing the Gemfile or the Docker configuration.
```
docker-compose build
docker-compose run web rake db:create db:seed
```

Then run the application as follows:

### Running the application

Starting the app should be as simple as executing `docker-compose up` from the project directory.
You can then access it by navigating to `0.0.0.0:3000` in your browser.

### Resetting the Database
Run the following commands to drop the database and seed it with new data. This will remove all entries and re-generate the database.

```
docker-compose down # Stops all instances
docker-compose run web rake db:reset # Drops all databases and creates new, seeded databases
```
In some cases you may have to run the second command a few times until it completes with no errors.

### Seeding the Database
If you want to manually seed the database with data, such as a test user, just run
`docker-compose run web rake db:seed`


## Using the project without Docker

### Setup
Run `bundle install` to fetch and install all required dependencies. Ensure running `ruby -v` shows a version >= 2.5.0 and `rails -v` shows a version >= 5.1.5

### Running the application
Run the application by entering `rails server` from the main project directory. Then navigate to `0.0.0.0:3000` in your browser.

### Authentication

Run 'rake db:seed' from the main project directory to create a user.

### Resetting the database

To reset the database, run `rails db:reset`. This will remove all entries and re-generate the database.


### Project Setup

### Ruby Version

For development, Ruby 2.5.0 and Rails 5.1.5 are used.
Type `ruby -v` and `rails -v` to check which version you're running.
If you're running the app using Docker, your system ruby and rails versions do not matter.

### Database configuration

The project uses PostgreSQL 10.3 as a database.
Type `postgres --version` to check which version you're running.
If you're running the app using Docker, your system Postgres version does not matter.