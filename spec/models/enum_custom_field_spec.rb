require 'rails_helper'

RSpec.describe EnumCustomField, type: :model do
  it { is_expected.to belong_to(:client) }
  it { is_expected.to validate_presence_of(:name) }
end
