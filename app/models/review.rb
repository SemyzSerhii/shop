class Review < ApplicationRecord
  belongs_to :product
  validates :rating, inclusion: 1..5, presence: true
  validates :text, presence: true, length: { minimum: 10, maximum: 1000 }
end
