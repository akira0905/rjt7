class UsersController < ApplicationController
 before_action :authenticate_user!
 before_action :ensure_correct_user, only: [:edit]
  def show
    @bookn = Book.new
    @book = Book.find(params[:id])
    @user = User.find(params[:id])
  end
  def index
    @user = current_user
    @users = User.all
    @book = Book.new
  end
  def edit
    @user = User.find(params[:id])
  end
   def ensure_correct_user
    @user = User.find_by(id:params[:id])
    if @user.user_id != @current_user.id
      flash[:notice] = "権限がありません"
      redirect_to("show")
    end
  end
  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:notice] ="You have updated book successfully."
      redirect_to user_path(current_user.id)
    else
      render "edit"
    end
  end

  private
  def user_params
      params.require(:user).permit(:name, :profile_image, :introduction)
  end


end
