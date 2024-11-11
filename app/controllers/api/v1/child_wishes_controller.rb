class Api::V1::ChildWishesController < ApplicationController
  def index
    @child_wishes = ChildWish.includes(:user, :present).all

    render :index, status: :ok
  end
end
