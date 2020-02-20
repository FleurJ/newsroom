class UsersAdministrationController < ApplicationController
  before_action :authenticate_user!
  before_action :redirect_non_admin

  def index
    @users = User.all
  end

  def edit
    @user = User.find(params[:id])
  end

  def new
    @user = User.new
  end

  def create
    user = User.new(params_user)
    if params_user[:password] == params_user[:password_confirmation]
      user.password = params_user[:password_confirmation]
      user.status = "inactif"
      user.save
      redirect_to users_administration_index_path
    else
      redirect_to new_users_administration_path
    end
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
    params.require(:user).permit(:name, :first_name, :agora_profil, :role, :status, :email, :password, :password_confirmation)
  end

end
