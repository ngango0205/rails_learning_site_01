class User < ApplicationRecord
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

  before_save :downcase_email
  validates :name,  presence: true,
    length: {maximum: Settings.maximum.length_name}
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true,
    length: {maximum: Settings.maximum.length_email},
    format: {with: VALID_EMAIL_REGEX},
    uniqueness: {case_sensitive: false}
  validates :password, presence: true,
    length: {minimum: Settings.minimum.length_pass}
  has_secure_password

  def follow other_user
    following << other_user
  end

  def unfollow other_user
    following.delete other_user
  end

  def following? other_user
    following.include? other_user
  end

  private

  def downcase_email
    email.downcase!
  end
end
