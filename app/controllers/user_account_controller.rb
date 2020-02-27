class UserAccountController < ApplicationController
  before_action :authenticate_user!

  def show
    @user ||= current_user
    if @user.subscribed == true
      @color = "green"
    else
      @color = ""
    end
  end

  def edit
    @user = current_user
  end

  def update
    @user = current_user
    @user.subscribed = params_subscription[:subscribed]
    if @user.update(password_params)
      redirect_to user_account_path(current_user)
    else
      render action: "show"
    end
  end

  private
  def params_subscription
    params.require(:user).permit(:subscribed)
  end

  def password_params
    params.require(:user).permit(:password, :password_confirmation, :reset_password_token)
  end

end
