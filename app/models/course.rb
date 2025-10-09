class Course < ApplicationRecord
  belongs_to :coding_class
  belongs_to :trimester
  has_many :enrollments # A course has many enrollment records
  has_many :students, through: :enrollments # A course has many students and you can get them by looking at the enrollments

  delegate :title, to: :coding_class
  # This method returns an array of emails fro all students enrolled in the course
  def student_email_list
    students.pluck(:email)
  end
end
