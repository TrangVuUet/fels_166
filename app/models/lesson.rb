class Lesson < ActiveRecord::Base
  belongs_to :user
  belongs_to :category
  has_many :results
  accepts_nested_attributes_for :results

  def create_questions
    self.category.words = if self.category.words.size >= Settings.number_words
      self.category.words.shuffle().take Settings.number_words
    else
      self.category.words.all.shuffle()
    end
  end
end
