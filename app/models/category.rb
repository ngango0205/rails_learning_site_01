class Category < ApplicationRecord
  has_many :lesson_categories
  has_many :lessons, through: :lesson_categories
end
