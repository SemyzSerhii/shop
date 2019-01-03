class Image < ApplicationRecord
  belongs_to :product
  mount_uploader :img, ImageUploader

  validates_presence_of :img
end
