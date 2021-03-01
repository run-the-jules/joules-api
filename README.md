# jules-api

## Background and Description

"jules-api" is the backend API only application that handles the bulk of data interface for other applications. jules-api is part of a consultancy group project Run The Jules that requires students to build service-oreinted architecture application that allows the user to authenticate through Google and their electricity provider to compare their energy usage with other users.


## Goals accomplished 
- Consumed microservice API endpoints to package data for the frontend to consume
- Robust unit and integration testing to ensure data quality
- Navigate working together with a larger application base with many moving parts
- Learned application design from the perspective of users' needs 
- Navigate how a small change can have huge impact in a SOA application
- Setup continuous integration and deployment
- Worked in short 3 or 4 day "Sprints" schedule
- Worked in pairs
- Deployed application to [Heroku](https://gentle-forest-90792.herokuapp.com/admin)

## Setup
This project requires Ruby 2.5.3.  
This project requires Rails 5.2.3 and later  
1. Clone this repository
```
git clone https://github.com/run-the-jules/RunTheJules-API
```
2. Install dependencies
```
bundle install
```
Note: you will need to install gem install bundler if you don't have bundler  

3. Database setup
```
rails db:setup
```
## Usage
Run the testing suite in the terminal with
```
bundle exec rspec
```
endpoints for User Utility Activation  
TBA

## Database Scheme
TBA

## Technologies
- Ruby
- Ruby on Rails
### Utilities
- rspec-rails
- factory_bot_rails
- faker
- simplecov
- webmock
- travis
- heroku



## Project details 
From [Turing School](https://backend.turing.io/module3/projects/consultancy/)

## Contributors
[James Fox-Collis](https://github.com/jlfoxcollis)  
[Alex Osborne](https://github.com/AlexanderOsborne)  
[Catherine Dean](https://github.com/catherinemdean15)  
[Joe Jiang](https://github.com/ninesky00)  
[Aiden Mendez](https://github.com/aidenmendez)  
[Robert Heath](https://github.com/kaiheiongaku)  
