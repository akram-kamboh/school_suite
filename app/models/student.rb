class Student < ApplicationRecord
  validates :full_name, presence: true, uniqueness: { case_sensitive: false, message: "has already been taken" },
            format: { with: /\A[a-zA-Z\s]+\z/, message: "can only contain letters" },
            length: { minimum: 2, maximum: 50 }

  # Marks: must be >= 100
  validates :marks, presence: true,
            numericality: { only_integer: true, less_than_or_equal_to: 100, message: "must be less than or equal to 100" }

  # Optional: Student type presence check
  validates :student_type, inclusion: { in: [true, false], message: "must be selected" }
end
