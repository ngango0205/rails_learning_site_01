class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
    :recoverable, :rememberable, :trackable, :validatable, :confirmable
  has_many :notifications, foreign_key: :recipient_id
  has_many :histories, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :lessons, dependent: :destroy
  has_many :follower_relations, class_name: UserRelation.name,
    foreign_key: "follower_id",
    dependent: :destroy
  has_many :followed_relations, class_name: UserRelation.name,
    foreign_key: "followed_id",
    dependent:   :destroy
  has_many :following, through: :follower_relations, source: :followed
  has_many :followers, through: :followed_relations, source: :follower
  has_many :likes

  scope :search, ->(q){where "name LIKE '%#{q}%'"}

  def current_user? current_user
    self == current_user
  end

  def follow other_user
    following << other_user
  end

  def unfollow other_user
    following.delete other_user
  end

  def following? other_user
    following.include? other_user
  end

  def likes? lesson
    lesson.likes.where(user_id: id).any?
  end
end
