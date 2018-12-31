class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  def self.search(search)
    Product.where('title ILIKE :search', search: "%#{search}%")
  end
end
