class Word < ActiveRecord::Base
  scope :search, ->(keyword) { where("category_id = ?", "#{keyword}") }

  belongs_to :category
  has_many :results
  has_many :word_answers, dependent: :destroy

  accepts_nested_attributes_for :word_answers,
    reject_if: proc {|attributes| attributes["content"].blank?}
end
