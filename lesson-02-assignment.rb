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
puts trimester.application_deadline

# Changing the values on Trimester and then call .save! to save those values in the database
trimester.application_deadline = '2025-08-25'
trimester.save!

# Call the .update! method and pass a hash of attributes to update
trimester.update(application_deadline: '2025-8-25')

# ---------------------------------------------------------------------------- #
# Task 4: Add a new mentor and offload some assignments for an overloaded mentor
# ---------------------------------------------------------------------------- #

Mentor.create(first_name: 'Frank', last_name: 'Smith', email: 'frank.smith@test.com')

# This line of code can also be written like this, similar to Javascript object literal
# It's common in Ruby to prefer the least amount of syntax that is still readable and valid.
# So the first style presented is more common to see.
Mentor.create({ "first_name": 'Frank', "last_name": 'Smith', "email": 'frank.smith@test.com' })

# Get all the Mentor Enrollment Assignment record for the mentor ID 22
mentor_assignments = MentorEnrollmentAssignment.where(mentor_id: 22)
puts "Found #{mentor_assignments.count} assignments for mentor 22"

# Lets choose the last one to update, assign it to a new variable

# Check if we found any assigments before proceeding
if mentor_assignments.any?
  assignment_to_update = mentor_assignments.last
  puts "Selected assigment ID: #{assignment_to_update.id}"
  puts ' '

  # Now, let's re-assign the enrollment to Frank. Get the ID of Frank's mentor record:
  frank = Mentor.find_by(email: 'frank.smith@test.com')
  puts "Frank's ID is: #{frank.id}" # get frank's ID

  # Update the mentor assigment record we retrieved from above with Frank's mentor ID
  assignment_to_update.update!(mentor_id: frank.id) # re-assigns the assigmetns to Frank
  puts 'Successfully reassigned assignment to Frank'
else
  puts 'No assignments found for mentor 22, cannot reassign'
end
puts ' '

################################## ASSIGMENT 2: WEEK 2################################

# ---------------------------------------------------------------------------- #
# Q1: Create Course records for each coding class in the Spring 2026 trimester
# ---------------------------------------------------------------------------- #

# Find the Spring2026 trimester:
spring2026 = Trimester.find_by(year: '2026', term: 'Spring')
puts "Year: #{spring2026.year}"

# Get all Coding Class records:
coding_classes = CodingClass.all
puts "Classes: #{coding_classes}"
puts ' '

# Testing the .create statement before including it in the loop
test_coding_class = coding_classes.first # Get the first coding class to test with

if test_coding_class
  puts "Testing with coding class: #{test_coding_class.title}"
  Course.create(
    coding_class_id: test_coding_class.id,
    trimester_id: spring2026.id
  )
  puts "Classes ID: #{test_coding_class.id}"
  puts "Trimester ID: #{spring2026.id}"
  puts 'Test course created successfully!'
else
  puts 'No coding classes found to test with'
end
puts ' '

# Loop through and create a Course for each one:
coding_classes.each do |coding_class|
  Course.create(
    coding_class_id: coding_class.id,
    trimester_id: spring2026.id
  )
  puts "Created course for: #{coding_class.title}"
end
puts ' '
puts 'Finished creating courses for Spring 2026!'
puts "Total courses created: #{coding_classes.count}"
puts ' '
