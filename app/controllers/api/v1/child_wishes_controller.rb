class Api::V1::ChildWishesController < Api::V1::ApiController
  def index
    @child_wishes = ChildWish.includes(:user, :present).all

    render :index, status: :ok
  end
end
