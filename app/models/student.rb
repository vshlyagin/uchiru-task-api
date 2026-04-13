class Student < ApplicationRecord
  belongs_to :school_class, foreign_key: :class_id
  belongs_to :school
end
