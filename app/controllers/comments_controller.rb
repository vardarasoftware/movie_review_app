class CommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_movie

  def create
    @comment = @movie.comments.build(comment_params.merge(user: current_user))
    if @comment.save
      redirect_to @movie, notice: "Comment posted."
    else
      redirect_to @movie, alert: @comment.errors.full_messages.to_sentence
    end
  end

  private

  def set_movie
    @movie = Movie.find(params[:movie_id])
  end

  def comment_params
    params.require(:comment).permit(:content)
  end
end
