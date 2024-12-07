class User < ApplicationRecord
  has_secure_password
  has_many :sessions, dependent: :destroy
  has_many :books, foreign_key: :author_user_id

  normalizes :email_address, with: ->(e) { e.strip.downcase }
end
