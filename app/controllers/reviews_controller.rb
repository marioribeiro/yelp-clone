class ReviewsController < ApplicationController
  before_action :authenticate_user!, :except => [:index, :show]

  def new
    @restaurant = Restaurant.find(params[:restaurant_id])
    @review = Review.new
  end

  def create
    @restaurant = Restaurant.find(params[:restaurant_id])
    @review = @restaurant.reviews.build_with_user(review_params, current_user)
    if @review.save
      redirect_to restaurants_path
    else
      if @review.errors[:user]
        redirect_to restaurants_path, alert: 'You have already reviewed this restaruant'
      else
        render :new
      end
    end
    
  end

  def destroy
    @review = Review.find(params[:id])
    @restaurant = @review.restaurant
    @review.destroy
    flash[:notice] = 'Review deleted successfully'
    redirect_to restaurants_path
  end

  private

  def review_params
    params.require(:review).permit(:thoughts, :rating)
  end

end
