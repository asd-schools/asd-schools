class SearchController < ApplicationController
  def index
    @schools = School.near(point).limit(10).offset(params[:page].to_i * 10)
  end

  private

  def point
    if params[:atlas_id]
      Atlas.all[params[:atlas_id]] or (raise ActiveRecord::RecordNotFound.new("atlas_id not found"))
    else
      ActiveRecord::Point.new(params[:lng], params[:lat])
    end
  end
end
