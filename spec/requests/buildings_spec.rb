require 'rails_helper'

RSpec.describe "Buildings", type: :request do
  describe "GET /index" do
    before do
      FactoryBot.create_list(:building, 3)
    end

    it "returns all buildings" do
      get "/buildings"
      expect(response.body).to eq("Widget was successfully created.")
    end
  end
end
