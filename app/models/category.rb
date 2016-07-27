class Category < ActiveRecord::Base
  scope :search, ->(keyword) { where("name LIKE ?", "%#{keyword}%") }
  has_many :words, dependent: :destroy
  has_many :lessons, dependent: :destroy

  validates :name, length: {minimum: 6}
end
