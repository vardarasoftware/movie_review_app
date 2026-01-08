class CommentsController < ApplicationController
  def index
    @comments = Comment.all
  end

  def show
    @comment = Comment.find(params[:id])
  end

  def new
    @comment = Comment.new
  end
  
  def create
    @comment = Comment.new(comment_params)
    if @comment.save
      redirect_to @comment, notice: "Comment created successfully."
    else
      render :new
    end
  end

  def edit
    @comment = Comment.find(params[:id])
  end

  def update
    @comment = Comment.find(params[:id])
    if @comment.update(comment_params)
      redirect_to @comment, notice: "Comment updated successfully."
    else
      render :edit
    end
  end

  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy
    redirect_to users_path, notice: "Comment deleted successfully"
  end
  
  private
  def comment_path
    params.require(:comment).permit(:title, :body)
  end

  def comment_params
    params.require(:comment).permit(:body, :user_id, :movie_id)
  end
end
