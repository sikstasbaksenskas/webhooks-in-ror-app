module HttpAuthConcern  
  extend ActiveSupport::Concern
  
  def http_basic_auth
    correct_user = Rails.application.credentials.http_auth[:user]
    correct_password = Rails.application.credentials.http_auth[:password]

    authenticate_or_request_with_http_basic do |user, password|
      return if user == correct_user && password == correct_password

      head :unauthorized
    end
  end
end
