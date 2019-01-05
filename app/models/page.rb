class Page < ApplicationRecord
  validates :title, presence: true, length: { minimum: 3 }
  validates :body, presence: true, length: { minimum: 20 }

  def to_param
    [id, title.parameterize].join("-")
  end
end
