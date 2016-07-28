class WordAnswersController < ApplicationController
  before_action :load_word, :logged_in_user, only: :index

  def index
    @answers = @word.word_answers
    flash[:danger] = t "user.word_answer.not_found" if @answers.nil?
    respond_to do |format|
      @html_content = render_to_string @answers
      format.js {render json: {answers: @html_content,
        word_id: params[:word_id]}}
    end
  end

  private
  def load_word
    @word = Word.find_by id: params[:word_id]
    flash[:danger] = t "user.word.not_found" if @word.nil?
  end
end
