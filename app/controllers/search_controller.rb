class SearchController < ApplicationController
  def index
    @schools = School.near(
      params[:lng],
      params[:lat]
    ).limit(10).offset(params[:page].to_i * 10)
  end
end
