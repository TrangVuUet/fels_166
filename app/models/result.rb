class Result < ActiveRecord::Base
  scope :correct, -> {where is_correct: true}
  scope :in_lesson, -> (lesson) {where lesson_id: lesson.id}
  belongs_to :lesson
  belongs_to :word
  belongs_to :word_answer

  def is_correct_answer?
    self.is_correct?
  end
end
