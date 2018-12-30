class Category < ApplicationRecord
  has_ancestry
  has_many :products, dependent: :destroy

  validates :title, presence: true, length: { minimum: 5 }, uniqueness: true
end
