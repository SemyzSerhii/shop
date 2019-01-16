class Setting < ApplicationRecord
  validates_presence_of :set_key, :set_value
  validates_length_of :set_value, minimum: 5
end
