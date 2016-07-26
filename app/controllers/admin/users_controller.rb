class Admin::UsersController < ApplicationController
  before_action :logged_in_user, except: [:show]
  before_action :find_user, only: [:show, :destroy]
  before_action :correct_admin, only: [:index, :show, :destroy]

  def index
    if params[:search]
      @users = User.search(params[:search]).paginate page: params[:page],
       per_page: Settings.per_page
    else
      @users = User.paginate page: params[:page], per_page: Settings.per_page
    end
  end

  def show
  end

  def destroy
    if @user.destroy
      flash[:success] = @user.name + t("user.delete.success_msg")
    else
      flash[:danger] = @user.name + t("user.delete.fail_msg")
    end
    redirect_to admin_users_url
  end
end
