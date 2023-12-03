class ApplicationController < ActionController::API
  include ActionController::HttpAuthentication::Basic::ControllerMethods
  include ActionController::HttpAuthentication::Token::ControllerMethods

  before_action :authenticate_user!

  private

  def authenticate_user!
    authenticate_or_request_with_http_basic do |email, password|
      @current_user = User.find_by(email: email)
      true if @current_user.authenticate(password)
    end
  end

  def current_user
    @current_user
  end
end
