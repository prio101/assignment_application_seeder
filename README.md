# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version

* System dependencies

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...


### Starting Instructions

1. Run `chmod +x entrypoint.sh` to make the entrypoint executable
2. Run `docker-compose up --build` to build the docker image and run the container
3. Run `docker-compose run web rake db:create` to create the database
4. Run `docker-compose run web rake db:migrate` to run the migrations
5. Run `docker-compose run web rake db:seed` to seed the database
6. Run `docker-compose run web rake db:seed RAILS_ENV=test` to seed the test database
7. Run `docker-compose run web rspec` to run the tests

### API Endpoints


