class Api::V1::BaseController < ApiController
  before_action :authorize_user, :current_user

  private
  def authorize_user
    doorkeeper_authorize! :user
  end

  def current_user
    @current_user ||= User.find_by id: doorkeeper_token.resource_owner_id if doorkeeper_token
  end

  def doorkeeper_unauthorized_render_options error: nil
    {json: {
      success: false,
      errors: [{
        code: 401,
        message: I18n.t("doorkeeper.errors.messages.unauthorized_client")
        }]
      }
    }
  end

  def doorkeeper_forbidden_render_options error: nil
    {json: {
      success: false,
      errors: [{
        code: 403,
        message: I18n.t("doorkeeper.errors.messages.access_denied")
        }]
      }
    }
  end
end
