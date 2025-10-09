# spec/models/course_spec.rb
require 'rails_helper'

RSpec.describe Course, type: :model do
  # Data setup for a test course
  # The data defined here (up to line 27) is used
  # for all the tests in this file.

  # let(:coding_class) defines the coding_class variable
  # let(:trimester) defines the trimester variable
  # let(:course) defines the course variable

  let(:coding_class) do
    CodingClass.create(title: 'Test Class')
  end
  let(:trimester) do
    Trimester.create(
      year: '2025',
      term: 'Winter',
      start_date: '2025-01-01',
      end_date: '2025-04-30',
      application_deadline: '2024-12-15'
    )
  end
  let(:course) do
    Course.create(coding_class: coding_class,
                  trimester: trimester)
  end

  # We define a "describe block" for each method or set of behaviors we're testing
  describe 'validations' do
    it 'is valid when both coding_class and trimester are present' do
      expect(course).to be_valid
    end

    it 'is not valid without a coding_class' do
      course.coding_class = nil
      expect(course).to_not be_valid
    end

    it 'is not valid without a trimester' do
      course.trimester = nil
      expect(course).to_not be_valid
    end
  end

  describe '.student_email_list' do # added new Line
    # First, we'll write a test that expects the method to exist
    # for an instance of a course
    it 'exists for a course' do
      expect { course.student_name_list }.not_to raise_error(NoMethodError)
    end

    # Then we'll define test case scenarios and describe what we expect
    # to happen when we call the method in each scenario
    context 'when there are NO students enrolled in the course' do
      # No additional data to set up in this scenario
      it 'returns an empty' do
        expect(course.student_name_list).to eq([])
      end
    end

    context 'when there are students enrolled in the course' do
      # Now we do have additional data to set up. We need
      # students enrolled in the test course defined above.
      #
      # Create some test student records
      let!(:enrolled_student_1) do
        Student.create!(
          first_name: 'Student',
          last_name: 'One',
          email: 'studentone@example.com'
        )
      end
      let!(:enrolled_student_2) do
        Student.create!(
          first_name: 'Student',
          last_name: 'Two',
          email: 'studenttwo@example.com'
        )
      end

      # The code in a "before block" runs before
      # the tests in this context are executed.
      # Here we create enrollment records for the course.
      before do
        Enrollment.create!(student: enrolled_student_1, course: course)
        Enrollment.create!(student: enrolled_student_2, course: course)
      end

      let(:expected_results) do
        [
          'Student One',
          'Student Two'
        ]
      end

      it 'returns an array of student names' do
        expect(course.student_name_list).to eq(expected_results)
      end
    end
  end

  describe '.student_email_list' do # added new Line
    it 'exists for a course' do
      expect { course.student_email_list }.not_to raise_error(NoMethodError)
    end

    context 'when there are NO students enrolled in the course' do
      # No additional data to set up in this scenario
      it 'returns an empty array' do
        expect(course.student_email_list).to eq([])
      end
    end

    context 'when there are students enrolled in the course' do
      # Create student records with dummy data
      let(:enrolled_student_1) do
        Student.create!(
          first_name: 'Student',
          last_name: 'One',
          email: 'studentone@example.com'
        )
      end
      let(:enrolled_student_2) do
        Student.create!(
          first_name: 'Student',
          last_name: 'Two',
          email: 'studenttwo@example.com'
        )
      end

      # Create enrollment records for the course
      before do
        Enrollment.create!(student: enrolled_student_1, course: course)
        Enrollment.create!(student: enrolled_student_2, course: course)
      end

      # This is what we expect the method to return
      let(:expected_results) do
        [
          'studentone@example.com',
          'studenttwo@example.com'
        ]
      end
      it 'returns an array of student email addresses' do
        expect(course.student_email_list).to eq(expected_results)
      end
    end
  end
end
