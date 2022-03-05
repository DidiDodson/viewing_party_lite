# Viewing Party Lite

## About this Project

Viewing Part Lite is an application in which users can explore movie options and create a viewing party event for themselves and other users of the application. It incorporates basic HTML views in the backend repo in addition to the base code.

This project consumes the [Movie DB API](https://www.themoviedb.org/documentation/api?language=en-US) to provide real-time data for each movie. This data includes reviews and rankings, as well as a list of the top 25 movies. Users can also search the database to find a movie and create a viewing party. The movie data is consumed via a facade and a service to abstract it out of the controller.

## Schema
![Viewing Party Lite Schema](app/assets/images/schema.png)
In addition to the database tables, this project incorporates a movie poro.

## Setup for the use of the project
1. Install gem packages: `bundle install`
2. Setup the database: `rails db:create`

## Technologies
![Rails](https://img.shields.io/badge/rails-%23CC0000.svg?style=for-the-badge&logo=ruby-on-rails&logoColor=white)
![Ruby](https://img.shields.io/badge/ruby-%23CC342D.svg?style=for-the-badge&logo=ruby&logoColor=white)
![Postgres](https://img.shields.io/badge/postgres-%23316192.svg?style=for-the-badge&logo=postgresql&logoColor=white)
- Ruby 2.7.2
- Rails 5.2.6
- Faraday gem
- bcrypt gem

## Testing
This project is tested using RSpec, Capybara, VCR, Webmock, SimpleCov, and Shouldmatchers.

## Sample Views
**_Login Page_**\
![Login Page](app/assets/images/homepage.png)
**_New User Creation_**\
![New User Page](app/assets/images/new_user_registration.png)
**_Discover Movies Page_**\
![Discover page](app/assets/images/discover.png)
**_Top 25 Movies_**\
![Top 25 Movies](app/assets/images/top_movies.png)
**_Movie Search Results_**\
![Movie Search Results](app/assets/images/search_results.png)
**_Movie Show Page_**\
![Movie Show](app/assets/images/movie_show.png)
