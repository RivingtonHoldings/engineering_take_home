class CustomFieldsSchemaBuilder
  def call(custom_fields)
    Dry::Schema.Params do
      custom_fields.each do |custom_field|
        case [ custom_field.class.name, custom_field.try(:input_type) ]
        when [ "EnumCustomField", nil ]
          optional(custom_field.name.to_sym).value(included_in?: custom_field.values)
        when [ "InputCustomField", "numeric" ]
          optional(custom_field.name.to_sym) { int? | float? | format?(/(\d+(?:\.\d+)?)/) }
        when [ "InputCustomField", "freeform" ]
          optional(custom_field.name.to_sym) { str? }
        else
          raise ArgumentError, "Invalid Model: #{custom_field.class.name}"
        end
      end
    end
  end
end
