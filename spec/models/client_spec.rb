require 'rails_helper'

RSpec.describe Client, type: :model do
  it { is_expected.to have_many(:buildings) }
  it { is_expected.to have_many(:enum_custom_fields) }
  it { is_expected.to have_many(:input_custom_fields) }
  it { is_expected.to validate_presence_of(:name) }

  describe "#custom_fields" do
    subject { client.custom_fields }

    let(:client) { FactoryBot.create(:client) }

    context "with custom fields" do
      let!(:custom_fields) do
        [
          FactoryBot.create(:input_custom_field, client:),
          FactoryBot.create(:enum_custom_field, client:)
        ]
      end

      it { is_expected.to contain_exactly(*custom_fields) }
    end

    context "without custom fields" do
      it { is_expected.to be_blank }
    end
  end
end
