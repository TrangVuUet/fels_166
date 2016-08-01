class WordAnswer < ActiveRecord::Base
  scope :correct, -> {where is_correct: true}
  belongs_to :word
  has_many :results
end
