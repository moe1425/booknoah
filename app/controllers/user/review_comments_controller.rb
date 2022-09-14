  class User::ReviewCommentsController < ApplicationController
    
    def create
      @review = Review.find(params[:review_id])
      @comment = current_user.review_comments.new(review_comment_params)
      @comment.review_id = review.id
      @comment.save
    end
    
    def destroy
      @review = Review.find(params[:review_id])
      @comment = ReviewComment.find(params[:id])
      @comment.destroy
    end
    
    private
    
    def review_comment_params
      params.require(:review_comment).permit(:comment)
    end
  end
