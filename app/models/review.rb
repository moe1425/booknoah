class Review < ApplicationRecord
  belongs_to :user
  belongs_to :book
  has_many :favorites, dependent: :destroy
  has_many :review_comments, dependent: :destroy
  
  validates :title, length: { minimum: 2, maximum: 50 }, presence: true
  validates :content, length: { minimum: 2, maximum: 1000 }, presence: true
  validates :star, numericality: {
    less_than_or_equal_to: 5,
    greater_than_or_equal_to: 1
  }, presence: true
  
  
  def favorited_by?(review, user)
    Favorite.exists?(review_id: review.id, user_id: user.id)
  end
  
end
