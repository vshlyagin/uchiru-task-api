class SchoolClass < ApplicationRecord
  has_many :students, foreign_key: :class_id
  belongs_to :school
end
