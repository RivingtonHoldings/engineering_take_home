class InputCustomField < ApplicationRecord
  belongs_to :client

  enum type: [ :freeform, :numeric ]
end
