class WordsController < ApplicationController
  before_action :logged_in_user, only: :index

  def index
    @categories = Category.all
    if params[:filter].eql? Settings.filter_learned
      word_ids = Result.word_ids_learned
      @words = Word.in_category(params[:category_id]).where(id: word_ids)
    elsif params[:filter].eql? Settings.filter_not_learned
      word_ids = Word.joins(:results).ids
      @words = Word.in_category(params[:category_id]).where.not(id: word_ids)
    else
      @words = Word.in_category(params[:category_id]).order(created_at: :asc).
        paginate page: params[:page], per_page: Settings.per_page
    end
    if @words.nil?
      flash[:danger] = t "user.word.not_found"
      redirect_to words_path
    end
  end
end
