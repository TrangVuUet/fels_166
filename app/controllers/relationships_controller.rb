class RelationshipsController < ApplicationController
  before_action :logged_in_user, only: [:create, :show, :destroy]
  before_action :find_user, only: :show

  def create
    @user = User.find_by id: params[:followed_id]
    if @user.nil?
      flash[:danger] = t "user.delete.not_exist_msg"
      redirect_to current_user
    else
      current_user.follow @user
      respond_to do |format|
        format.html {redirect_to @user}
        format.js
      end
    end
  end

  def show
    @users = @user.send("#{params[:query]}").paginate page: params[:page],
      per_page: Settings.per_page
  end

  def destroy
    @user = Relationship.find_by(id: params[:id]).followed
    if @user.nil?
      flash[:danger] = t "user.delete.not_exist_msg"
      redirect_to current_user
    else
      current_user.unfollow @user
      respond_to do |format|
        format.html {redirect_to @user}
        format.js
      end
    end
  end
end
