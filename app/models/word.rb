class Word < ActiveRecord::Base
  belongs_to :category
  has_many :results
  has_many :word_answers, dependent: :destroy

  validates :content, length: {minimum: 6}
end
