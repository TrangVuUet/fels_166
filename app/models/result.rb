class Result < ActiveRecord::Base

  scope :word_ids_learned, -> do
    where("word_answer_id is not null").pluck(:word_id)
  end
  scope :word_ids_not_learned, -> do
    where("word_answer_id is null").pluck(:word_id)
  end
  scope :is_correct, ->{where is_correct: true}
  scope :in_lesson, -> lesson {where lesson_id: lesson.id}
  scope :learned_word, -> (user_id) {where QUERY_LEARNED, user_id}
  scope :learned, -> (user_id) {where QUERY_LEARNED, user_id}
  scope :all_words, -> {joins(lesson: :user).where("")}
  belongs_to :lesson
  belongs_to :word
  belongs_to :word_answer
  delegate :is_correct, to: :word_answer
end
