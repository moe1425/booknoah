class UserBook < ApplicationRecord
  belongs_to :user
  belongs_to :book
  
  validates :is_read, inclusion: {in: [true, false]}
  
end
