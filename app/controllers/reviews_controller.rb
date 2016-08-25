class ReviewsController < ApplicationController
  def new
    @review = Review.new(review_params)
    @review.school = school
  end

  def create
    @review = Review.new(review_params)
    @review.published = true
    @review.school = school
    if @review.save
      redirect_to school_url(school)
    else
      render :new
    end
  end

  private

  def school
    @school ||= School.find(params[:school_id])
  end

  def review_params
    params.fetch(:review, {}).permit(
      :review_type,
      :score,
      :pros,
      :cons,
      :comments,
      child_characteristics: []
    )
  end
end
