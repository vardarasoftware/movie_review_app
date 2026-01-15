class AdminsController < ApplicationController
  def index
    @admin = Admin.all
  end

  def show
    @admin = Admin.find(params[:id])
  end

  def new
    @admin = Admin.new
  end

  def create
    @admin = Admin.new(admin_params)
    if @admin.save
      redirect_to @admin, notice: "admin created successfully."
    else
      render :new
    end
  end

  def edit
    @admin = Admin.find(params[:id])
  end

  def update
    @admin = Admin.find(params[:id])
    if @admin.update(admin_params)
      redirect_to @admin, notice: "admin updated successfully."
    else
      render :edit
    end
  end


  def destroy
    @admin = Admin.find(params[:id])
    @admin.destroy
    redirect_to admins_path, notice: "admin deleted successfully."
  end

  private
  def admin_params
    params.require(:admin).permit(:name, :email, :password)
  end

  def admin_path
    params.require(:admin).permit(:title, :body)
  end
end

