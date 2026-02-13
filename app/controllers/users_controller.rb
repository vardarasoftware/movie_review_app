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
    SendWelcomeEmailJob.perform_later(@user)
    redirect_to root_path, notice: "User created successfully"

    # respond_to do |format|
    #   if @user.save
    #     # Tell the UserMailer to send a welcome email after save
    #     UserMailer.with(user: @user).welcome_email.deliver_later

    #     format.html { redirect_to user_url(@user), notice: "User was successfully created." }
    #     format.json { render :show, status: :created, location: @user }
    #   else
    #     format.html { render :new, status: :unprocessable_entity }
    #     format.json { render json: @user.errors, status: :unprocessable_entity }
    #   end
    # end
  end 
  
  # def create
  #   @user = User.new(user_params)
  #   if @user.save
  #     redirect_to @user, notice: "User created successfully."
  #   else
  #     render :new
  #   end
  # end

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
