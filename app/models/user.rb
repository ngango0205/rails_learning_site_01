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
end
