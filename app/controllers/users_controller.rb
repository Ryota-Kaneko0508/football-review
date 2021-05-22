class UsersController < ApplicationController
  before_action :require_user_logged_in, only: [:show]
  
  def show
    @user = User.find(params[:id])
    @reviews = @user.reviews.order(id: :desc).page(params[:page])
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    
    if @user.save
      flash[:success] = "会員登録が完了しました"
      redirect_to login_url
    else
      flash.now[:danger] = '会員登録に失敗しました'
      render :new
    end
  end
  
  def likes
    @user = User.find(params[:id])
    @likes = @user.likes_reviews.page(params[:page])
  end
  
  private
  
  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end
