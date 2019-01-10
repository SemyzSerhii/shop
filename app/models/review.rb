class Review < ApplicationRecord
  belongs_to :product
  belongs_to :user

  scope :publish, -> { where(status: true) }
  scope :unpublish, -> { where(status: false) }

  validates :rating, inclusion: 1..5, presence: true
  validates :text, presence: true, length: { minimum: 10, maximum: 500 }
end
