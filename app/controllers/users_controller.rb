class UsersController < ApplicationController

  before_action :logged_in_user, except: [:show, :new, :create]
  before_action :load_user, except: [:index, :new, :create]
  before_action :correct_user, only: [:edit, :update]

  def new
    @user = User.new
  end

  def create
    @user = User.new user_params
    if @user.save
      log_in @user
      flash[:success] = t "signup_success_msg"
      redirect_to @user
    else
      render :new
    end
  end

  def index
    if params[:search]
      @users = User.search(params[:search]).paginate page: params[:page],
       per_page: Settings.per_page
    else
      @users = User.paginate page: params[:page], per_page: Settings.per_page
    end
  end

  def show
    @lessons = Lesson.user_own current_user
    @lessons = Lesson.paginate page: params[:page], per_page: Settings.per_page
  end

  def edit
  end

  def update
    if @user.update_attributes user_params
      @user.activity_user_update @user.id, nil, Settings.activity_user_update
      flash[:success] = t "edit_user.update_success"
      redirect_to @user
    else
      render :edit
    end
  end

  private
  def user_params
    params.require(:user).permit :name, :email, :password,
     :password_confirmation, :avatar
  end
end
