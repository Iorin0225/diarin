class Book < ApplicationRecord
  has_many :articles, dependent: :destroy
end
