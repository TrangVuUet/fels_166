class Admin::CategoriesController < ApplicationController
  before_action :verify_admin
  before_action :load_category, only: [:destroy, :edit, :update]

  def index
    @categories = Category.order(created_at: :desc).paginate page: params[:page],
      per_page: Settings.per_page
  end

  def new
    @category = Category.new
  end

  def create
    @category = Category.new category_params
    if @category.save
      flash[:success] = t "messages.create_success"
      redirect_to new_admin_categories_path
    else
      render :new
    end
  end

  def destroy
    if @category.destroy
      flash[:success] = t "admin.category.destroy.success"
    else
      flash[:danger] = t "admin.category.destroy.error"
    end
    redirect_to request.referrer
  end

  def edit
  end

  def update
    if @category.update_attributes category_params
      flash[:success] = t "admin.category.update.success"
      redirect_to admin_categories_path
    else
      flash[:danger] = t "admin.category.update.error"
      render :edit
    end
  end

  private
  def category_params
    params.require(:category).permit :name
  end

  def load_category
    @category = Category.find_by id: params[:id]
    if @category.nil?
      flash[:danger] = t "admin.category.find"
      redirect_to request.referrer
    end
  end
end
