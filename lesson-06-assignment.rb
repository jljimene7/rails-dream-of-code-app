################################## LESSON 6 ASSIGNMENT ################################
#
# Goal:
# - Write request specs that test the mentors list route (GET /mentors)
# - Write request specs that test the mentors show route (GET /mentors/:id)
#
# Where the implementation lives:
# - spec/requests/mentors_spec.rb
#
# How to run ONLY these specs:
#   bundle exec rspec spec/requests/mentors_spec.rb
#
# What passing looks like:
# - GET /mentors returns 200 and includes mentor data in the HTML
# - GET /mentors/:id returns 200 and includes the specific mentor’s data
# - (extra) GET /mentors/:id returns 404 when record not found
#
# Notes:
# - This app already has the routes via `resources :mentors` in config/routes.rb
# - Views used by these routes:
#   - app/views/mentors/index.html.erb
#   - app/views/mentors/show.html.erb
#   - app/views/mentors/_mentor.html.erb
