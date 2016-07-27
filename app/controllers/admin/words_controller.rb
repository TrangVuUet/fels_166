class Admin::WordsController < ApplicationController
  before_action :verify_admin

  def new
    @word = Word.new
    @answers = @word.word_answers.build
  end

  def create
    @word = Word.create word_params
    if @word.save
      flash[:success] = t "messages.create_success"
      redirect_to root_path
    else
      flash[:danger] = t "messages.create_failed"
      render :new
    end
  end

  private
  def word_params
    params.require(:word).permit :content,
      word_answers_attributes: [:content, :is_correct]
  end
end
