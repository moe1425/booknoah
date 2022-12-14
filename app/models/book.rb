class Book < ApplicationRecord
    has_many :user_books
    has_many :reviews, dependent: :destroy
    has_many :reviewed_users, through: :reviews, source: :user
end
