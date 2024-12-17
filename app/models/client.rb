class Client < ApplicationRecord
  has_many :buildings
  has_many :input_custom_fields
  has_many :enum_custom_fields

  validates :name, presence: true
end
