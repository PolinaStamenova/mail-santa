class Api::V1::ApiController < ActionController::API
  before_action :authenticate_user!

  private

  def authenticate_user!
    # TODO: Implement authentication logic
  end
end
