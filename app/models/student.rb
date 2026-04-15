class Student < ApplicationRecord
  belongs_to :school_class, class_name: 'SchoolClass', foreign_key: 'class_id', counter_cache: :students_count
  belongs_to :school

  validates :first_name, :last_name, :surname, presence: true

  validate :class_must_belong_to_school

  private

  def class_must_belong_to_school
    return unless school_class && school

    if school_class.school_id != school.id
      errors.add(:class_id, "must belong to the specified school")
    end
  end
end
