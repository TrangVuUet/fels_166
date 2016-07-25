class Admin::AdminController < ApplicationController
  before_action :verify_admin

  def verify_admin
    unless logged_in? && current_user.admin?
      flash[:danger] = t "messages.admin_login"
      redirect_to root_path
    end
  end
end
