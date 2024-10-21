class ChildWishesController < ApplicationController
  def new
    @child_wish = ChildWish.new
  end

  def create
    @present = Present.create_from_letter(child_wish_params[:letter])

    if @present
      @child_wish = ChildWish.new(user_id: current_user.id, present_id: @present.id)

      if @child_wish.save
        flash.now.notice = 'Your wish has been sent to Santa!'
        redirect_to user_session_path
      else
        flash.now.alert = "Sorry, Santa couldn't understand your wish. Please try again and be more specific."
        render :new
      end
    else
      flash.now.alert = "Sorry, Santa couldn't understand your wish. Please try again and be more specific."
      render :new
    end
  end

  private

  def child_wish_params
    params.require(:child_wish).permit(:letter)
  end
end
