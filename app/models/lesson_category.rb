class LessonCategory < ApplicationRecord
  belongs_to :lesson
  belongs_to :category
end
