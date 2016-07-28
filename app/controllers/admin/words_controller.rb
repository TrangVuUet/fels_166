class Admin::WordsController < ApplicationController
  before_action :logged_in_user, :verify_admin

  def new
    @word = Word.new
    @answers = @word.word_answers.build
  end

  def create
    @word = Word.create word_params
    if @word.save
      flash[:success] = t "messages.create_success"
      redirect_to admin_words_path
    else
      flash[:danger] = t "messages.create_failed"
      render :new
    end
  end

  def index
    @categories = Category.all
    if params[:search]
      @words = Word.search(params[:search]).paginate page: params[:page],
        per_page: Settings.per_page
    else
      @words = Word.order(created_at: :desc).paginate page: params[:page],
        per_page: Settings.per_page
    end
  end

  private
  def word_params
    params.require(:word).permit :content,
      word_answers_attributes: [:content, :is_correct]
  end
end
