class Review < ApplicationRecord
  belongs_to :user
  belongs_to :book
  has_many :favorites, dependent: :destroy
  has_many :review_comments, dependent: :destroy
  has_many :notifications, dependent: :destroy
  
  validates :title, length: { minimum: 2, maximum: 50 }, presence: true
  validates :content, length: { minimum: 2, maximum: 1000 }, presence: true
  validates :star, numericality: {
    less_than_or_equal_to: 5,
    greater_than_or_equal_to: 1
  }, presence: true
  
  
  def favorited_by?(review, user)
    Favorite.exists?(review_id: review.id, user_id: user.id)
  end
  
  # いいね通知
  def create_notification_favorite(current_user)
    favorited = Notification.where(["visiter_id = ? and visited_id = ? and review_id = ? and action = ?",current_user.id, user_id, id, "favorite"])
    
    if favorited.blank?
      notification = current_user.active_notifications.new(
        review_id: id,
        visited_id: user_id,
        action: "favorite"
      )
      if notification.visiter_id != notification.visited_id
        notification.save
      end
    end
  end
  
  # コメント通知
  def create_notification_comment(current_user, review_comment_id)
    # 自分以外のコメントしているユーザーを取得
    review_comment_user_ids = ReviewComment.where(review_id: id).where.not(user_id: [current_user.id, user_id]).distinct
    review_comment_user_ids.each do |review_comment_user_id|
      save_notification_comment(current_user, review_comment_id, review_comment_user_id['user_id'])
    end
    # 自分の記事へのコメントは通知を作らない
    save_notification_comment(current_user, review_comment_id, user_id) if user_id != current_user.id
  end

  def save_notification_comment(current_user, review_comment_id, visited_id)
    notification = current_user.active_notifications.new(
      review_id: id,
      review_comment_id: review_comment_id,
      visited_id: visited_id,
      action: "comment"
    )
    
    notification.save
  end
end
