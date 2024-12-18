class CustomFieldsSchemaBuilder
  def call(custom_fields)
    Dry::Schema.Params do
      custom_fields.each do |custom_field|
        case custom_field
        when EnumCustomField
          optional(custom_field.name.to_sym).value(included_in?: custom_field.values)
        when InputCustomField
          optional(custom_field.name.to_sym).value(type?: custom_field.to_type)
        else
          raise ArgumentError, "Invalid Model: #{custom_field.class}"
        end
      end
    end
  end
end
