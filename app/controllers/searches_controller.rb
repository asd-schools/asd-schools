class SearchesController < ApplicationController
  def index
    if params[:autocomplete]
      # Autocomplete search
      if params[:autocomplete].length > 3
        render json: School.ransack(name_cont: params[:autocomplete]).result
      else
        render json: []
      end
    else
      # Form search
      @search = Search.new(search_params)
      @schools = @search.results
    end
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
