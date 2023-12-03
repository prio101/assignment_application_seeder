module AuthorizationHeaderHelper
  def basic_auth_headers(email, password)
    {
      'HTTP_AUTHORIZATION' => ActionController::HttpAuthentication::Basic.encode_credentials(email, password)
    }
  end
end
