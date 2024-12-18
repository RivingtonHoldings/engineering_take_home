require 'rails_helper'

describe CustomFieldsBuilder, type: :service do
  describe "#call" do
    subject(:call) { described_class.new.call(custom_fields:, schema:) }

    let(:schema) do
      Dry::Schema::Params {
        optional(:house_type).value(included_in?: [ "cape_code", "tudor" ])
        optional(:bathrooms) { int? | float? | format?(/(\d+(?:\.\d+)?)/) }
        optional(:description) { str? }
      }
    end

    context "with valid custom_fields" do
      let(:custom_fields) do
        {
          house_type: "cape_code",
          bathrooms: 0,
          description: "Great curb apeal"
        }
      end

      it "returns the custom fields" do
        expect(call).to be_success
        expect(call.value!).to eq(custom_fields)
      end
    end

    context "with invalid custom_fields" do
      let(:custom_fields) do
        {
          house_type: "wrong_enum",
          bathrooms: "big"
        }
      end

      it "returns errors" do
        expect(call).not_to be_success
        expect(call.failure).to contain_exactly(
          "house_type must be one of: cape_code, tudor",
          "bathrooms must be an integer or bathrooms must be a float or bathrooms is in invalid format"
        )
      end
    end

    context "with valid and invalid custom_fields" do
      let(:custom_fields) do
        {
          house_type: "cape_code",
          bathrooms: "big"
        }
      end

      it "returns errors" do
        expect(call).not_to be_success
        expect(call.failure).to contain_exactly("bathrooms must be an integer or bathrooms must be a float or bathrooms is in invalid format")
      end
    end

    context "without custom fields" do
      let(:custom_fields) { {} }

      it "returns custom fields with empty values" do
        expect(call).to be_success
        expect(call.value!).to eq(
          house_type: "",
          bathrooms: "",
          description: ""
        )
      end
    end
  end
end
