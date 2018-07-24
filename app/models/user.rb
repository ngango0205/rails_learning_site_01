class User < ApplicationRecord
  has_many :histories, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :follower_relations, class_name: UserRelation.name,
    foreign_key: "follower_id",
    dependent: :destroy
  has_many :followed_relations, class_name: UserRelation.name,
    foreign_key: "followed_id",
    dependent:   :destroy
  has_many :following, through: :follower_relations, source: :followed
  has_many :followers, through: :followed_relations, source: :follower

  before_save :downcase_email
  validates :name,  presence: true, length: {maximum: Settings.size.length_max}
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true,
    length: {maximum: Settings.size.length_max_email},
    format: {with: VALID_EMAIL_REGEX},
    uniqueness: {case_sensitive: false}

  private

  def downcase_email
    email.downcase!
  end
end
