class SearchController < ApplicationController
  def index
    @schools = School.near(
      params[:lat],
      params[:lng]
    ).limit(10).offset(params[:page].to_i * 10)
  end
end
