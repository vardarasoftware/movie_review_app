class UsersController < ApplicationController
  def index
    @q = User.ransack(params[:q])
    @users = @q.result
    @pagy, @users = pagy(@users, limit: 5)
    #@users = User.all
  end

  def show
    @user = User.find(params[:id])
    @reviews = @user.reviews
    @ratings = @user.ratings
  end

  def new
    @user = User.new
  end
  
  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to @user, notice: "User created successfully."
    else
      render :new
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to @user, notice: "User updated successfully."
    else
      render :edit
    end
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    redirect_to users_path, notice: "User deleted successfully"
  end
  
  private
  def user_path
    params.require(:user).permit(:title, :body,)
  end

  def user_params
    params.require(:user).permit(:name, :email, :password,)
  end
end
