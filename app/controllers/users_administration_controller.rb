class UsersAdministrationController < ApplicationController
  before_action :authenticate_user!
  before_action :redirect_non_admin

  def index
    @users = User.all
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    @user.update(params_user)
    @user.save
    redirect_to users_administration_index_path
  end

  private

  def redirect_non_admin
    redirect_to root_path unless current_user.role === "admin"
  end

  def params_user
    params.require(:user).permit(:name, :first_name, :agora_profil, :role, :status)
  end

end
