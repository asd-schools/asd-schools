class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  def require_basic_auth
    request_http_basic_authentication unless authenticate_with_http_basic do |u, p|
      u == "admin" && p == ENV['ADMIN_PASSWORD']
    end
  end
end
