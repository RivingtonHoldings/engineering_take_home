require 'rails_helper'

RSpec.describe Building, type: :model do
  it { is_expected.to belong_to(:client) }
  it { is_expected.to validate_presence_of(:street_address_one) }
  it { is_expected.to validate_presence_of(:city) }
  it { is_expected.to validate_presence_of(:state) }
  it { is_expected.to validate_presence_of(:zipcode) }
end
