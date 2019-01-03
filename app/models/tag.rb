class Tag < ApplicationRecord
  belongs_to :filter
  belongs_to :product

  validates :tag, presence: true, length: { minimum: 3 }
end
