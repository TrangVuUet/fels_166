class Lesson < ActiveRecord::Base
  include CreateActivity

  scope :correct, -> {where is_correct=true}
  scope :user_own, -> (user) {where user_id: user.id}
  before_create :create_questions
  belongs_to :user
  belongs_to :category
  has_many :results, dependent: :destroy

  validates :category, presence: true

  accepts_nested_attributes_for :results

  after_create :activity_create
  after_update :activity_update

  def create_questions
    if self.category.words.size >= Settings.number_words
      words = self.category.words.shuffle().take Settings.number_words
   else
      words = self.category.words.all.shuffle()
    end
    words.each do |word|
      self.results.build word_id: word.id
    end
  end

  def number_correct
    if self.is_complete?
      Result.correct.in_lesson(self).count
    end
  end
  private
  def activity_create
    create_activity self.user_id, self.id, Settings.activity_lesson_create
  end

  def activity_update
    create_activity self.user_id, self.id, Settings.activity_lesson_do
  end
end
