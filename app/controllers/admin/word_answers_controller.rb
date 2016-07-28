class Admin::WordAnswersController < ApplicationController
  before_action :logged_in_user, :verify_admin, :load_word

  def index
    @answers = @word.word_answers
    respond_to do |format|
      @html_content = render_to_string @answers
      format.js {render json: {answers: @html_content,
        word_id: params[:word_id]}}
    end
  end

  private
  def load_word
    @word = Word.find_by id: params[:word_id]
    if @word.nil?
      flash[:danger] = t "admin.category.find"
      redirect_to request.referrer
    end
  end
end
