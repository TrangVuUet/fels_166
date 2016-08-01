class LessonsController < ApplicationController
  before_action :logged_in_user
  before_action :load_lesson, :correct_user_lesson, only: [:edit, :update, :show]
  before_action :load_category, only: :create
  before_action :verify_completed_lesson, only: [:edit, :update]
  before_action :verify_uncompleted_lesson, only: :show

  def create
    @lesson = Lesson.new category_id: @category.id, user_id: current_user.id
    if @lesson.save
      flash[:success] = t "user.lesson.success_msg"
       redirect_to edit_lesson_path @lesson
    else
      flash[:danger] = t "user.lesson.failed_msg"
      redirect_to categories_path
    end
  end

  def edit
  end

  def update
    completed_lesson_params = lesson_params
    if params[:commit].eql? t("user.lesson.submit_btn")
      completed_lesson_params[:is_complete] = true
      @lesson.update_attributes completed_lesson_params
      redirect_to @lesson
    else
      completed_lesson_params[:is_complete] = false
      @lesson.update_attributes completed_lesson_params
      flash[:warning] = t "user.lesson.save_success_msg"
      redirect_to user_path current_user
    end
  end

  def show
  end


  private
  def load_category
    @category = Category.find_by id: params[:category_id]
  end

  def load_lesson
    @lesson = Lesson.find_by id: params[:id]
    unless @lesson
      flash[:danger] = t "user.lesson.no_lesson_found"
      redirect_to categories_path
    end
  end

  def correct_user_lesson
    unless current_user.current_user? @lesson.user
      flash[:danger] =  t "user.lesson.correct_user_lesson"
      redirect_to root_url
    end
  end

  def lesson_params
    params.require(:lesson).permit :is_complete,
      results_attributes: [:id, :word_answer_id]
  end

  def verify_completed_lesson
    if @lesson.is_complete?
      flash[:danger] = "Already submit."
      flash.now[:info] = t "user.lesson.verify_completed_lesson"
      redirect_to lesson_path @lesson
    end
  end

  def verify_uncompleted_lesson
    unless @lesson.is_complete?
      flash[:danger] = t "user.lesson.verify_uncompleted_lesson"
      redirect_to edit_lesson_path @lesson
    end
  end
end
