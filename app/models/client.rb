class Client < ApplicationRecord
  has_many :buildings
  has_many :input_custom_fields
  has_many :enum_custom_fields

  validates :name, presence: true

  def custom_fields
    input_custom_fields.to_a + enum_custom_fields.to_a
  end
end
