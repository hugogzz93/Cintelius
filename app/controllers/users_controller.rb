class UsersController < ApplicationController

  before_filter :authenticate_user!

  # def edit
  #   @user = current_user
  # end

  def update_password

    respond_to do |format|
      format.js {
        @user = User.find(current_user.id)
        if @user.update_with_password(user_params)
          sign_in @user, :bypass => true
          @success = true
          # Sign in the user by passing validation in case their password changed
          # redirect_to root_path
        else
          # render "edit"
        end 
      }
    end
  end

  private

  def user_params
    # NOTE: Using `strong_parameters` gem
    params.require(:user).permit(:password, :password_confirmation, :current_password)
  end
end