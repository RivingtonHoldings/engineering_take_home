class CustomFieldsBuilder
  include Dry::Monads[:result]

  def call(schema:, custom_fields:)
    schema_field_names = schema.key_map.keys.map(&:name).map(&:to_sym)
    custom_fields = filter_custom_fields(schema_field_names:, custom_fields:)
    result = schema.call(custom_fields)

    if result.success?
      Success(add_defaults(schema_field_names:, custom_fields:))
    else
      Failure(result.errors(full: true).to_h.values.flatten)
    end
  end

  private

  def filter_custom_fields(schema_field_names:, custom_fields:)
    invalid_field_names = custom_fields.keys.map(&:to_sym) - schema_field_names
    custom_fields.except(invalid_field_names)
  end

  def add_defaults(schema_field_names:, custom_fields:)
    schema_field_names.each do |name|
      custom_fields[name] ||= ""
    end

    custom_fields
  end
end
