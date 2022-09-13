class Review < ApplicationRecord
  belongs_to :user
  belongs_to :book
  has_many :favorites, dependent: :destroy
  
  def favorited_by?(user)
    avorites.exists?(user_id: user.id)
  end
  
  validates :title, length: { minimum: 2, maximum: 50 }, presence: true
  validates :content, length: { minimum: 2, maximum: 250 }, presence: true
  validates :star, numericality: {
    less_than_or_equal_to: 5,
    greater_than_or_equal_to: 1
  }, presence: true
  
end
