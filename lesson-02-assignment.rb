################################## LESSON WEEK 2################################
# ---------------------------------------------------------------------------- #
# Task 2: Add courses, enrollments and mentors assigments for upcoming trimester
# ---------------------------------------------------------------------------- #
spring2025 = Trimester.find_by(year: '2025', term: 'Spring')
spring2025.year
spring2025.term
spring2025.application_deadline

puts '----Task 2: Add courses, enrollments and mentors assigments for upcoming trimester---'
puts ' '
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
puts '----Task 3: Change the application deadline on the upcoming trimester to give----'
puts ' '
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
puts '----Task 4: Add a new mentor and offload some assignments for an overloaded mentor----'
puts ' '
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
puts '===== Q1: Create Course records for each coding class in the Spring 2026 trimester ====='
puts ' '
puts "Year: #{spring2026.year}"

# Get all Coding Class records:
coding_classes = CodingClass.all
puts 'CODING CLASSES'
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

# ----------------------------------------------------------------------------------------- #
# Q2: Create New Student, Enroll, Assign Mentor
# ----------------------------------------------------------------------------------------- #

# 1. Create a new student
new_student = Student.create(first_name: 'Luis', last_name: 'Salvador',
                             email: 'luis.salvador@test.com')

# 2. Enroll them in the Intro to Programming for Spring 2026

# Check twhat columns are available in CodingClass
puts '===== Q2: Create New Student, Enroll, Assign Mentor ====='
puts ' '
puts "CodingClass columns: #{CodingClass.column_names}"
puts ' '
intro_class1 = CodingClass.find_by(title: 'Intro to Programming')
intro_course = Course.find_by(coding_class_id: intro_class1.id, trimester_id: spring2026.id)

# Create the enrollment
enrollment = Enrollment.create(student_id: new_student.id, course_id: intro_course.id)
puts "Created enrollment for #{new_student.first_name}"
puts ' '

# 3. Find a mentor with no more (<=) than 2 students

# Count how any assigment each mentor has
mentor_counts = MentorEnrollmentAssignment.group(:mentor_id).count
puts "Current mentor assigment counts: #{mentor_counts}"

# Find mentors with 2 or fewer students
suitable_mentors = mentor_counts.select { |mentor_id, count| count <= 2 }
puts "Mentors with <= 2 assignments: #{suitable_mentors}"
puts ' '

if suitable_mentors.any?
  # pick the first suitable mentor
  chosen_mentor_id = suitable_mentors.keys.first
  mentor_finder = Mentor.find(chosen_mentor_id)
  puts "Found suitable mentor: #{mentor_finder.first_name}
                               #{mentor_finder.last_name}
                              (#{suitable_mentors[chosen_mentor_id]} current assignments) "
elsif mentor_counts.any?
  # If no mentor has <= 2 assignments, find the one with the fewest
  min_count = mentor_counts.values.min
  chosen_mentor_id = mentor_counts.find { |id, count| count == min_count }.first
  mentor_finder = Mentor.find(chosen_mentor_id)
  puts "No mentor with <= 2 assignments found. Using mentor with fewest students:
              #{mentor_finder.first_name} #{mentor_finder.last_name} (#{min_count} assignments)"
  puts ' '
else
  # If no assignment exists at all, just pick any mentor
  mentor_finder = Mentor.first
  puts "No existing assignment found. Using first available mentor:
        #{mentor_finder.first_name} #{mentor_finder.last_name}"
  puts ' '
end
puts ' '

# 4. Assign this found mentor to the new student
if mentor_finder
  mentor_assignments = MentorEnrollmentAssignment.create(mentor_id: mentor_finder.id, enrollment_id: enrollment.id)
  puts "Successfully assigned mentor #{mentor_finder.first_name} #{mentor_finder.last_name} to student #{new_student.first_name}"
  puts "Assignment ID #{mentor_assignments.id}"
  puts 'Q2 completed! '
else
  puts 'Error: No mentor available for assigment'
  puts ' '
end
puts ' '

# ----------------------------------------------------------------------------------------- #
# Q3: Describe my chosen project:
# ----------------------------------------------------------------------------------------- #
# OVERVIEW:
#  A web app that converts a customer problem statement + specifications into a draft quote
#  that includes machine configuration, component selection, pricing, and margin calculations.
#  The system references past quotes, vendor prices, and internal pricing sheets,
#  and includes a human‑in‑the‑loop review before finalization.
#  Draft quotes can be exported to PDF/invoice format.
#
# USERS AND ROLES:
#  Staff (Sales/Engineer):
#     Creates and edits quotes based on customer problem statements and specifications.
#     Selects machine configurations, components, and customizations from a stored catalog.
#     Can reference past quotes, vendor prices, and internal pricing sheets.
#  Manager (Reviewer/Approver):
#     Reviews draft quotes, adjusts margins if needed, requests changes,
#     approves final quotes, and exports them as PDF invoices.
#
# Intake:           Staff enters customer details, problem statement, and technical specs.
# Configuration:    Staff selects machine setup, components, and variable customizations.
# Pricing & Margin: System pulls data from vendor prices and internal pricing sheets, then calculates totals and margins.
# Review:           Manager reviews, can adjust values, or send back for changes.
# Finalization:     Manager approves; system generates an exportable PDF/invoice.
# ----------------------------------------------------------------------------------------- #

# ----------------------------------------------------------------------------------------- #
# Q4: Design the data model for your project
# ----------------------------------------------------------------------------------------- #

# # Users
#   id
#   name
#   email
#   role
#   created_at
#   updated_at

# # Customers
#   id
#   name
#   contact_name
#   contact_email
#   industry
#   created_at
#   updated_at

# # Quotes
#   id
#   customer_id (FK)
#   user_id (FK)
#   status
#   problem_statement
#   specifications
#   machine_configuration
#   margin_percentage
#   margin_amount
#   total_price
#   created_at
#   updated_at

# # Vendors
#   id
#   name
#   contact_email
#   created_at
#   updated_at

# # Components
#   id
#   vendor_id (FK)
#   name
#   description
#   unit_price_vendor
#   unit_price_internal
#   customizable_attributes
#   created_at
#   updated_at

# # QuoteComponents
#   id
#   quote_id (FK)
#   component_id (FK)
#   quantity
#   price_at_quote_time
#   customizations
#   created_at
#   updated_at

# # PricingSheets (Optional)
#   id
#   component_id (FK)
#   price_type
#   price
#   effective_date
#   created_at
#   updated_at
