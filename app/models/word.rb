class Word < ActiveRecord::Base
  scope:search, ->(keyword, category_id) {
    where("content LIKE ? OR category_id = ?", "%#{keyword}%", "#{category_id}")
  }
  belongs_to :category
  has_many :results
  has_many :word_answers, dependent: :destroy

  accepts_nested_attributes_for :word_answers,
    reject_if: proc {|attributes| attributes["content"].blank?}
 end
