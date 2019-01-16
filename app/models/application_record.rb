class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  def self.search(search)
    Product.where('title ILIKE :search', search: "%#{search}%")
  end

  def change_title
    self.title = self.title.capitalize
  end
end
