class InputCustomField < ApplicationRecord
  belongs_to :client

  enum input_type: [ :freeform, :numeric ]

  validates :name, presence: true
end
