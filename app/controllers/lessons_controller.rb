class LessonsController < ApplicationController
  before_action :load_category, only: :create

  def create
    @lesson = current_user.lessons.build category_id: @category.id
    if @lesson.save
      flash[:success] = t "user.lesson.success_msg"
    else
      flash[:danger] = t "user.lesson.success_failed"
    end
    redirect_to  new_lesson_result_path(@lesson)
  end

  private
  def load_category
    @category = Category.find_by id: params[:category_id]
  end
end
