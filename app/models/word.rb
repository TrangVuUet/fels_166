class Word < ActiveRecord::Base
  scope:search, ->(keyword, category_id) {
    where("content LIKE ? OR category_id = ?", "%#{keyword}%", "#{category_id}")
  }
  scope:search_category, ->(category_id = 0) {
    where("category_id is null OR category_id = ?", "#{category_id}")
  }
  scope:filter_category, ->(category_id = 0){
    where("category_id = ?", "#{category_id}")
  }

  belongs_to :category
  has_many :results
  has_many :word_answers, dependent: :destroy

  validate :validate_answer
  validates :content, presence: true, length: {minimum: 1}

  accepts_nested_attributes_for :word_answers, allow_destroy: true,
    reject_if: proc {|attributes| attributes["content"].blank?}

  def update_category! category
    if self.results.blank?
      return self.update_attribute :category_id, category.id
    end
    return false
  end

  def destroy_category!
    if self.results.blank?
      return self.update_attribute :category_id, nil
    end
    return false
  end

  def correct_answer
    self.word_answers.correct.first
  end

  def validate_answer
    size_correct = self.word_answers.select{|answer| answer.is_correct}.size
    if size_correct == 0
      errors.add "answer_is_correct", I18n.t("messages.validate_answer_size_correct")
    end
    size_correct_content = self.word_answers.select{|answer|
      answer.content.blank?}.size
    if size_correct_content != 0
      errors.add "answer_content", I18n.t("messages.validate_answer_blank")
    end
    size_correct_answer = self.word_answers.select{|answer|
      answer._destroy}.size
    size_correct_answer = self.word_answers.size - size_correct_answer
    if Settings.answer_default > size_correct_answer ||
      size_correct_answer >= Settings.max_answer
      errors.add "answer_size", I18n.t("messages.validate_answer_size")
    end
  end
end
