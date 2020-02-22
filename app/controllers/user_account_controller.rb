class UserAccountController < ApplicationController
  before_action :authenticate_user!

  def show
    @user = current_user
  end

  def edit
    @user = current_user
  end

  def update
    user = current_user
    if password_params[:password].nil? == false
      if password_params[:password].length >= 6
        if password_params[:password] == password_params[:password_confirmation]
          user.password = password_params[:password]
        end
      end
    end
    user.subscribed = params_subscription[:subscribed]
    user.save
    redirect_to user_account_path(current_user)
  end

  private
  def params_subscription
    params.require(:user).permit(:subscribed)
  end

  def password_params
    params.require(:user).permit(:password, :password_confirmation)
  end

end
