class SearchesController < ApplicationController
  def index
    @search = Search.new(search_params)
    @schools = @search.results
  end

  def create
    redirect_to action: :index, search: search_params.as_json
  end

  private
  def search_params
    params.require(:search).permit(
      :lat,
      :lng,
      :school_type,
      :autism_classification,
      :sector,
      :page,
      :suburb,
      :atlas_id
    )
  end
end
