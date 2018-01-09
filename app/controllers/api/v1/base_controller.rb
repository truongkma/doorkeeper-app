class Api::V1::BaseController < ApiController
  before_action :authorize_user, :current_user

  private
  def authorize_user
    doorkeeper_authorize! :user
  end

  def current_user
    @current_user ||= User.find_by id: doorkeeper_token.resource_owner_id if doorkeeper_token
  end
end
