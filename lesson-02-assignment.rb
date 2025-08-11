################################## LESSON WEEK 2################################
# ---------------------------------------------------------------------------- #
# Task 2: Add courses, enrollments and mentors assigments for upcoming trimester
# ---------------------------------------------------------------------------- #

spring2025 = Trimester.find_by(year: '2025', term: 'Spring')
spring2025.year
spring2025.term
spring2025.application_deadline

puts "Year: #{spring2025.year}"
puts "Term: #{spring2025.term}"
puts "Application Deadline: #{spring2025.application_deadline}"

# ---------------------------------------------------------------------------- #
# Task 3: Change the application deadline on the upcoming trimester to give
#         students more time to apply
# ---------------------------------------------------------------------------- #

# The trimester instance is an in-memory copy of the data in the row of the
# database table for that trimester
trimester = Trimester.find_by(term: 'Fall', year: '2025')
puts trimenster.application_deadline

# Changing the values on Trimester and then call .save! to save those values in the database
trimester.application_deadline = '2025-08-25'
trimester.save!

# Call the .update! method and pass a hash of attributes to update
trimester.update(application_deadline: '2025-8-25')
