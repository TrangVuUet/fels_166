class WordAnswer < ActiveRecord::Base
  belongs_to :word
  has_many :results

  validates :content, length: {minimum: 6}
end
