class Filter < ApplicationRecord
  acts_as_taggable_on :tags

  validates :title, presence: true, length: { minimum: 3 }, uniqueness: true

  before_save :change_title
end
