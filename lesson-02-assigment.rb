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
