  class User < ApplicationRecord
    # Include default devise modules. Others available are:
    # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
    devise :database_authenticatable, :registerable,
      :recoverable, :rememberable, :validatable
    
    has_many :reviews, dependent: :destroy
    has_many :reviewed_books, through: :reviews, source: :book
    has_many :favorites, dependent: :destroy
    has_many :favorite_reviews, through: :favorite, source: :review
    has_many :user_books, dependent: :destroy
    has_many :books, through: :user_books
    has_many :review_comments, dependent: :destroy
    has_one_attached :profile_image
    
    
    validates :name, presence: true, length: { minimum: 2, maximum: 50 }
    validates :introduction, length: { maximum: 255 }
    
    def get_profile_image(width, height)
      if !profile_image.attached?
        file_path = Rails.root.join('app/assets/images/default-image.jpg')
        profile_image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
      end
      profile_image.variant(resize_to_limit: [width, height]).processed
    end
    
    def self.guest
      find_or_create_by!(name: 'ゲストユーザー' ,email: 'guest@example.com') do |user|
        user.password = SecureRandom.urlsafe_base64
        user.name = "ゲストユーザー"
      end
    end
  end
