require 'rails_helper'

describe CustomFieldsSchemaBuilder, type: :service do
  describe "#call" do
    subject { described_class.new.call(custom_fields).to_ast }

    context "with custom_fields" do
      let(:custom_fields) do
        [
          FactoryBot.create(:enum_custom_field, name: "house_type", values: [ "cape_code", "tudor" ]),
          FactoryBot.create(:input_custom_field, name: "bathrooms", input_type: :numeric),
          FactoryBot.create(:input_custom_field, name: "description", input_type: :freeform)
        ]
      end

      let(:expected_schema) do
        Dry::Schema::Params {
          optional(:house_type).value(included_in?: [ "cape_code", "tudor" ])
          optional(:bathrooms) { int? | float? | format?(/(\d+(?:\.\d+)?)/) }
          optional(:description) { str? }
        }
      end

      it { is_expected.to eq(expected_schema.to_ast) }
    end

    context "without custom_fields" do
      let(:custom_fields) { [] }

      let(:expected_schema) do
        Dry::Schema::Params { }
      end

      it { is_expected.to eq(expected_schema.to_ast) }
    end
  end
end
