class Tag < ApplicationRecord
  belongs_to :filter
  belongs_to :product

  validates :tag, presence: true, length: { minimum: 3 }

  before_save :change_data

  private

  def change_data
    self.tag = self.tag.downcase
  end
end
