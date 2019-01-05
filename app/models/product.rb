class Product < ApplicationRecord
  belongs_to :category
  has_many :reviews, dependent: :destroy
  has_many :images, dependent: :destroy
  accepts_nested_attributes_for :images, allow_destroy: true

  has_many :tags
  accepts_nested_attributes_for :tags, allow_destroy: true

  scope :publish, -> { where(in_stock: true) }
  scope :unpublish, -> { where(in_stock: false) }

  validates :title, presence: true, length: { minimum: 3 }
  validates :price, presence: true, format: { with: /\A\d+(?:\.\d{0,2})?\z/ },
            numericality: { greater_than_or_equal_to: 0, less_than_or_equal_to: 1000000 }
  validates :short_description, presence: true, length: { minimum: 10, maximum: 500 }
  validates :full_description, presence: true, length: { minimum: 20, maximum: 5000 }

  def to_param
    [id, title.parameterize].join("-")
  end
end
