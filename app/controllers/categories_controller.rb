class CategoriesController < ApplicationController
  before_action :logged_in_user, only: :index

  def index
    if params[:search]
      @categories = Category.search(params[:search]).order(created_at: :desc).
        paginate page: params[:page], per_page: Settings.per_page
    else
      @categories = Category.order(created_at: :desc).
        paginate page: params[:page], per_page: Settings.per_page
    end
  end
end
