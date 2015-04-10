class CommentsController < ApplicationController
  before_action :authenticate_user!

  def new
    @comment = Comment.new
    @review = Review.find(params[:review_id])
  end

  def create
    @comment = current_user.comments.new(comment_params)
    @review = Review.find(params[:review_id])
    sitcom = @review.sitcom
    @comment.review_id = params[:review_id]
    if @comment.save
      flash[:notice] = "Your comment was added!"
    else
      flash[:alert] = "Comment can't be blank."
    end
    redirect_to sitcom
  end

  def edit
    @comment = current_user.comments.find(params[:id])
    @review = Review.find(params[:review_id])
    @sitcom = @review.sitcom
  end

  def update
    @comment = current_user.comments.find(params[:id])
    sitcom = @comment.review.sitcom
    if @comment.update(comment_params)
      flash[:notice] = "Your comment was updated!"
    else
      flash[:alert] = "Comment can't be blank."
    end
    redirect_to sitcom
  end

  def destroy
    @comment = current_user.comments.find(params[:id])
    sitcom = @comment.review.sitcom
    @comment.destroy
    flash[:notice] = 'Comment deleted'
    redirect_to sitcom
  end

  private

  def comment_params
    params.require(:comment).permit(:body, :user)
  end
end
