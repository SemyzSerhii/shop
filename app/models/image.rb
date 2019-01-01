class Image < ApplicationRecord
  belongs_to :product
  mount_uploader :img, ImageUploader
end
