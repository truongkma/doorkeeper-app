class User < ApplicationRecord
  DOORKEEPER_SIGN_IN_PARAMS = [:grant_type, :email, :password]
  DOORKEEPER_REFRESH_TOKEN_PARAMS = [:grant_type, :refresh_token]

  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :trackable, :validatable
end
