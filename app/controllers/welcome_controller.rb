class WelcomeController < ApplicationController
  def index
    @schools = School.limit(10)
    @search = Search.new(params[:search])
  end
end
