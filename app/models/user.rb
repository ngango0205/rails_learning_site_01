class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
    :recoverable, :rememberable, :trackable, :validatable, :confirmable,
    :omniauthable, omniauth_providers: [:facebook, :google_oauth2]
  has_many :notifications, foreign_key: :recipient_id
  has_many :histories, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :lessons, dependent: :destroy
  has_many :follower_relations, class_name: UserRelation.name,
    foreign_key: :follower_id,
    dependent: :destroy
  has_many :followed_relations, class_name: UserRelation.name,
    foreign_key: :followed_id,
    dependent:   :destroy
  has_many :following, through: :follower_relations, source: :followed
  has_many :followers, through: :followed_relations, source: :follower
  has_many :likes

  scope :search, ->(q){where "name LIKE '%#{q}%'"}

  class << self
    def new_with_session params, session
      super.tap do |user|
        if data = session["devise.facebook_data"] &&
                  session["devise.facebook_data"]["extra"]["raw_info"]
          user.email = data["email"] if user.email.blank?
        end
      end
    end

    def from_omniauth auth
      where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
        user.email = auth.info.email
        user.password = Devise.friendly_token[0, 20]
        user.name = auth.info.name
        user.role = 1
      end
    end
  end

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
