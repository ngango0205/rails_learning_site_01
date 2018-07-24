class Lesson < ApplicationRecord
  belongs_to :user
  has_many :histories
  has_many :history_users, class_name: User.name, through: :history
  has_many :lesson_categories
  has_many :lessons, through: :lesson_categories
end
