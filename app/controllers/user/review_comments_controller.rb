  class User::ReviewCommentsController < ApplicationController
    
    def create
      @book = Book.find(params[:book_id])
      @review = Review.find(params[:review_id])
      @review_comment = current_user.review_comments.new(review_comment_params)
      @review_comment.review_id = @review.id
      @review_comment.save
      @review_comments = @review.review_comments
      @review.create_notification_comment(current_user, @review_comment.id)
    end
    
    def destroy
      @review = Review.find(params[:review_id])
      @review_comment = ReviewComment.find(params[:id])
      @review_comment.destroy
    end
    
    private
    
    def review_comment_params
      params.require(:review_comment).permit(:comment).merge(user_id: current_user.id)
    end
  end