class WelcomeController < ApplicationController
  def index
    @schools = School.limit(10)
    @search = Search.new(params[:search])
  end

  def about
  end
  def privacy
  end
end
