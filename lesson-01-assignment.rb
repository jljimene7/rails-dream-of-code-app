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
puts "Upcoming trimester: #{upcoming_trimester.inspect}"
puts "Courses found: #{courses.count}"
puts courses_names