class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include SessionsHelper

  def logged_in_user
    unless logged_in?
      store_location
      flash[:danger] = t "edit_user.not_login"
      redirect_to login_url
    end
  end

  def correct_user
    redirect_to root_url unless current_user.current_user? @user
  end

  def correct_admin
    redirect_to root_url unless current_user.admin?
  end

  def find_user
    @user = User.find_by id: params[:id]
    if @user.nil?
      flash[:danger] = t "user.delete.not_exist_msg"
      redirect_to root_url
    end
  end
end
