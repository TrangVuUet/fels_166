class Admin::CategoriesController < Admin::AdminController

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

  private
  def category_params
    params.require(:category).permit :name
  end
end
