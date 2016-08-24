class SuburbsController < ApplicationController
  def index
    render json: SuburbsIndex.instance.search(params[:q])
  end
end
