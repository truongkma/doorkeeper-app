class Api::V1::SessionsController < Doorkeeper::TokensController
  def create
    params_validation
    server.parameters[:scope] = "user" if params[:grant_type] == "password"
    ActiveRecord::Base.transaction do
      customize_authorize_response
    end

    render json: {
      success: true,
      data: {access_token: access_token.token, refresh_token: access_token.refresh_token}
    }
  end

  private
  def params_validation
    case params[:grant_type]
    when "password"
      params_validator User::DOORKEEPER_SIGN_IN_PARAMS
    when "refresh_token"
      params_validator User::DOORKEEPER_REFRESH_TOKEN_PARAMS
    else
      raise ArgumentError
    end
  end

  def params_validator require_params
    require_params.each {|param| raise ArgumentError unless params.has_key?(param)}
  end

  def access_token
    @access_token ||= authorize_response.token
  end

  def customize_authorize_response
    raise APIError::DoorkeeperToken::InvalidToken.new unless authorize_response.status == :ok
  end
end
