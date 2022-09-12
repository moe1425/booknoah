class Book < ApplicationRecord
    
    has_many :reviews, dependent: :destroy
    
    validates :is_read, presence: true
end
