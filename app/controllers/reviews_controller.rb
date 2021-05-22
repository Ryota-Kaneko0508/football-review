class ReviewsController < ApplicationController
  before_action :require_user_logged_in
  before_action :correct_user, only: [:destroy]
  
  def index
    @user = User.all
    @reviews = Review.order(id: :desc).page(params[:page])
  end

  def new
    @review = Review.new
  end

  def create
    @review = current_user.reviews.build(review_params)
    if @review.save
      flash[:success] = 'レビューを投稿しました。'
      redirect_to reviews_url
    else
      @reviews = current_user.reviews.order(id: :desc).page(params[:page]) 
      flash.now[:danger] = 'レビューの投稿に失敗しました。'
      render :new
    end
  end

  def destroy
    @review.destroy
    flash[:success] = 'レビューを削除しました。'
    redirect_back(fallback_location: root_path) 
  end
  
  private
  
  def review_params
    params.require(:review).permit(:content, :match)
  end
  
  def correct_user
    @review = current_user.reviews.find_by(id: params[:id])
    unless @review
      redirect_to root_url
    end
  end  
end
