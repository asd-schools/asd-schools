class WelcomeController < ApplicationController
  def index
    @schools = School.limit(10)
  end
end
