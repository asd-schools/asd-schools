class SchoolsController < ApplicationController
  def show
    @school = School.find(params[:id])
    @review = Review.new(params[:review])
  end
end
