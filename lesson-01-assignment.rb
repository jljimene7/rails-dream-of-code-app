# ---------------------------------------------------------------------------- #
#            Task 1: Email current Intro students about upcoming courses
# ---------------------------------------------------------------------------- #
# Find the upcoming trimester (Fall 2025)
upcoming_trimester = Trimester.find_by(term:'Fall', year:2025)

# Get the courses for that Trimester
courses = Course.where(trimester_id: upcoming_trimester.id)

# Get coding class names
courses_names = courses.map do |course|
  coding_class = CodingClass.find(course.coding_class_id)
  "#{course.id}, #{coding_class.title} - #{upcoming_trimester.term} #{upcoming_trimester.year}"
end

# ---------------------------------------------------------- #
#    Task 1: Print each formatted course name to the output 
# ---------------------------------------------------------- #

# Find the upcoming trimester (Fall 2025)
upcoming_trimester = Trimester.find_by(term:'Fall', year:2025)

if upcoming_trimester.nil?
  puts "No trimester found for Fall 2025"
  exit
end

# Get the courses for that Trimester
courses = Course.where(trimester_id: upcoming_trimester.id)

if courses.empty?
  puts "No courses found for trimester #{upcoming_trimester.id}"
  exit
end

# Get coding class names
courses_names = courses.map do |course|
  coding_class = CodingClass.find(course.coding_class_id)
  "#{course.id}, #{coding_class.title} - #{upcoming_trimester.term} #{upcoming_trimester.year}"
end

# Printing course name to the output 
puts "\n===================="
puts "Task 1: Upcoming Courses"
puts "===================="
puts "Upcoming trimester: #{upcoming_trimester.inspect}"
puts "Courses found: #{courses.count}"
puts courses_names
puts "\n"  # Add a blank line after Task 1 output

# ----------------------------------------------------------------------------------- #
# Q1- Finish Task 1: Collect emails for students in the current intro course
# ----------------------------------------------------------------------------------- # 

# Find the "Intro to Programming" coding class
intro_class = CodingClass.find_by(title: 'Intro to Programming')

# Find the Spring 2025 trimester
spring_trimester = Trimester.find_by(term: 'Spring', year: 2025)

if intro_class.nil? || spring_trimester.nil?
  puts "Intro class or Spring 2025 trimester not found"
  exit
end

# Find the specific course for "Intro to Programming - Spring 2025"
intro_course = Course.find_by(coding_class_id: intro_class.id, trimester_id: spring_trimester.id)

if intro_course.nil?
  puts "Intro to Programming - Spring 2025 course not found"
  exit
end

# Find enrollments for this course (limit to 2 students)
enrollments = Enrollment.where(course_id: intro_course.id).limit(2)

if enrollments.empty?
  puts "No students enrolled in Intro to Programming - Spring 2025"
  exit
end

# Print student id and email for each enrollment
puts "===================="
puts "Q1: Emails for Students in Intro to Programming - Spring 2025"
puts "===================="
enrollments.each do |enrollment|
  student = Student.find_by(id: enrollment.student_id)
  puts "#{student.id}, #{student.email}" if student
end
puts "\n"  # Add a blank line after Q1 output