class ApplicationController < ActionController::API
  before_action :authenticate_user!

  private

  def authenticate_user!
    authenticate_or_request_with_http_basic do |username, password|
      @current_user = User.find_by(username: username, password: password)
      @current_user.present?
    end
  end

  def current_user
    @current_user
  end
end
