class ReviewsController < ApplicationController

  def create
    @review = Review.new(review_params)
    @review.school = school
    @review.published = school.publish_new_reviews_by_default
    if @review.save
      flash[:message] = "Reviews for this school are not shown until approved by a moderator." unless @review.published
      redirect_to school_url(school)
    else
      render "schools/show"
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
