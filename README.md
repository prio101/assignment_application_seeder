### Starting Instructions

1. Run `chmod +x entrypoint.sh` to make the entrypoint executable
2. Run `docker compose build` to build the docker image and run the container then run `docker compose up`.
3. Run `docker compose run web rake db:create` to create the database
4. Run `docker compose run web rake db:migrate` to run the migrations
5. Run `docker compose run web rake db:seed` to seed the database
6. Run `docker compose run web rake db:seed RAILS_ENV=test` to seed the test database
7. Run `docker compose run web rspec` to run the tests
8. Run `docker compose run --service-ports web` to run the server
9. Run `docker compose down` to stop the server
10. Run `docker compose run web bash` to run bash in the container
    -> From here you also can interact with the database using `rails c` or `rails dbconsole`

### API Endpoints

Here are we have the API endpoints that you can use to interact with the application:
We have the collection for apis for POSTMAN in This Link: `https://api.postman.com/collections/2329385-c37ec82d-f743-4240-ac4d-4deb31c48408?access_key=PMAT-01HGR2EC22KXJ4ZW2NH7CR6BKJ`


#### Database Schema in a nutshell:

Here we are attaching an ERD representation of the database schema:

- Entity-Relationship Diagram (ERD)

```
+----------------+       +------------------+       +---------------+
|    businesses  |       |    buy_orders    |       |     users     |
+----------------+       +------------------+       +---------------+
| id             |<------| id               |       | id            |
| name           |       | quantity         |       | email         |
| shares_available|      | price            |       | password_digest|
| owner_id       |------>| buyer_id         |<------| first_name     |
| created_at     |       | business_id      |       | last_name      |
| updated_at     |       | status           |       | created_at     |
| status         |       | created_at       |       | updated_at     |
+----------------+       | updated_at       |       +---------------+
                        +------------------+

```


#### RSPEC Coverage:

1. Added Unit Tests for all the models
2. Added Integration Tests for all the controllers

You can check the coverage by running `docker compose run web rspec` and then opening the `coverage/index.html` file in your browser.
**Estimated Coverage: > 95%**


### Variations of Web Application:

There are few variation for this single application available right now on three different branches:
1. `main` -> has the basic implementation of the application, with controller providing the API responses.
2. `fast_json_api` -> has the implementation of the application using fast_json_api, with controller -> serializer providing the API responses.
3. `jbuilder` -> has the implementation of the application using jbuilder, with controller -> jbuilder views providing the API responses. (This branch does not have the proper test coverage yet. You will have to use the POSTMAN collection to test the endpoints.)
