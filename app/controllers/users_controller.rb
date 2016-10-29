class UsersController < ApplicationController
  before_action :find_user, only: [:edit, :update, :destroy]

  def index
    @users = User.all
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to :users, flash: { notice: t('shop.users.create_notice') }
    else
      render 'new'
    end
  end

  def edit
  end

  def update
    if @user.update(user_params)
      redirect_to [:edit, @user], flash: { notice: t('shop.users.update_notice') }
    else
      render 'edit'
    end
  end

  def destroy
    fail Error, t('shop.users.self_remove_error') if @user == current_user
    @user.destroy
    redirect_to :users, flash: { notice: t('shop.users.destroy_notice') }
  end

  private
  def find_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:first_name, :last_name, :email_address, :password, :password_confirmation)
  end
end
