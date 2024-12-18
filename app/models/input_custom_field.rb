class InputCustomField < ApplicationRecord
  belongs_to :client

  enum input_type: [ :freeform, :numeric ]

  def to_type
    case input_type
    when "freeform"
      String
    when "numeric"
      Numeric
    else
      nil
    end
  end
end
