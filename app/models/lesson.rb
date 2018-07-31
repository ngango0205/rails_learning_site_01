class Lesson < ApplicationRecord
  belongs_to :user
  has_many :comments
  has_many :histories
  has_many :history_users, class_name: User.name, through: :history
  belongs_to :category

  validates :name, presence: true
  validates :description, presence: true
  validates :content, presence: true
  has_many :likes
  scope :search, ->q{where "name LIKE '%#{q}%'"}
  scope :order_by_name, ->{order name: :asc}
end
