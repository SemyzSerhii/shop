class Product < ApplicationRecord
  validates :title, presence: true, length: { minimum: 5 }
  validates :price, presence: true, format: { with: /\A\d+(?:\.\d{0,2})?\z/ },
            numericality: { greater_than: 0, less_than: 1000000 }
  validates :short_description, presence: true, length: { minimum: 10, maximum: 200 }
  validates :full_description, presence: true, length: { minimum: 20, maximum: 3000 }

end
