class WordsController < ApplicationController
  before_action :logged_in_user, only: :index

  def index
    @categories = Category.all
    if params[:word]|| params[:category_id]
      @words = Word.search(params[:word], params[:category_id]).
        order(created_at: :desc).paginate page: params[:page],
        per_page: Settings.per_page
    else
      @words = Word.order(created_at: :desc).
        paginate page: params[:page], per_page: Settings.per_page
    end
  end
end
