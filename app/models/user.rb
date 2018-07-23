class User < ApplicationRecord
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
