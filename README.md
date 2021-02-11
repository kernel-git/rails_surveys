# Surveys Project

### Application Setup

* Type ` git clone https://github.com/boss078/rails_surveys ` to clone this repo
* Then you should update Yarn packages with ` yarn install --check-files `
* Run all migrations by typing ` rails db:migrate `
* To populate databse with initial data type ` rails db:seed `
### Using Surveys Project
* To start server type ` rails s `
* To start backgroung job for statistic update you sould
  * start redis server by typing ` redis-server ` in new terminal
  * start sidekiq by typing ` bundle exec sidekiq ` in another terminal window 

Now you can access web application on localhost:3000/ in your browser
