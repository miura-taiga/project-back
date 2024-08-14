class ApplicationController < ActionController::API
  before_action :authenticate_request

  protected

  def authenticate_request
    token = cookies.signed[:auth_token]
    if token
      begin
        @decoded = JwtService.decode(token)
        if @decoded['provider'] == 'guest'
          @current_user = User.find(@decoded['user_id'])
        else
          user_auth = UserAuthentication.find_by(uid: @decoded['google_user_id'], provider: @decoded['provider'])
          @current_user = user_auth.user if user_auth
        end
        Rails.logger.info(@current_user)
        raise ActiveRecord::RecordNotFound, 'User not found' unless @current_user
      rescue ActiveRecord::RecordNotFound, JWT::DecodeError => e
        Rails.logger.error "認証エラー: #{e.message}"
        render json: { redirect_url: "#{ENV['NEXT_PUBLIC_API_URL']}/pages/login" }, status: :unauthorized
      end
    else
      render json: { redirect_url: "#{ENV['NEXT_PUBLIC_API_URL']}/pages/login" }, status: :unauthorized
    end
  end
end
