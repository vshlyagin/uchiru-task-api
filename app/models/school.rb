class School < ApplicationRecord
  has_many :school_classes
  has_many :students
end
