require 'rails_helper'

RSpec.describe "Buildings", type: :request do
  describe "GET /buildings" do
    before do
      FactoryBot.create_list(:building, 3)
    end

    it "returns all buildings" do
      get "/buildings"
      expect(response.content_type).to start_with("application/json")
      expect(response).to have_http_status(:ok)
    end
  end

  describe "GET /buildings/:id" do
    let!(:building) { FactoryBot.create(:building) }

    it "returns the building" do
      get "/buildings/#{building.id}"
      expect(response.content_type).to start_with("application/json")
      expect(response).to have_http_status(:ok)
    end
  end

  describe "POST /buildings" do
    let(:client) { FactoryBot.create(:client) }
    let!(:enum_custom_field) { FactoryBot.create(:enum_custom_field, client: client) }
    let!(:input_custom_field) { FactoryBot.create(:input_custom_field, input_type: :numeric, client: client) }
    let(:params) do
      {
          building: {
            client_id: client.id,
            street_address_one: Faker::Address.street_address,
            street_address_two: Faker::Address.secondary_address,
            city: Faker::Address.city,
            state: Faker::Address.state_abbr,
            zipcode: Faker::Address.zip_code
          }
        }
    end

    context "with valid custom fields values" do
      let(:expected_building_attributes) do
        {
          **params[:building].except(
            enum_custom_field.name.to_sym,
            input_custom_field.name.to_sym
          ),
          custom_fields: {
            enum_custom_field.name => enum_custom_field.values.first,
            input_custom_field.name => "0.0"
          }
        }
      end

      before do
        params[:building][enum_custom_field.name.to_sym] = enum_custom_field.values.first
        params[:building][input_custom_field.name.to_sym] = 0.0
      end

      it "creates a building" do
        headers = { "ACCEPT" => "application/json" }
        post "/buildings", params: params, headers: headers

        expect(response.content_type).to start_with("application/json")
        expect(response).to have_http_status(:created)
        expect(Building.last).to have_attributes(**expected_building_attributes)
      end
    end

    context "with an invalid custom fields value" do
      before do
        params[:building][enum_custom_field.name.to_sym] = "wrong enum"
        params[:building][input_custom_field.name.to_sym] = 0.0
      end

      it "returns an error" do
        headers = { "ACCEPT" => "application/json" }
        post "/buildings", params: params, headers: headers

        expect(response.content_type).to start_with("application/json")
        expect(response).to have_http_status(:bad_request)
      end
    end
  end

  describe "PUT /buildings/:id" do
    let(:client) { FactoryBot.create(:client) }
    let!(:enum_custom_field) { FactoryBot.create(:enum_custom_field, client: client) }
    let!(:input_custom_field) { FactoryBot.create(:input_custom_field, input_type: :numeric, client: client) }
    let!(:building) { FactoryBot.create(:building, client: client, custom_fields: { enum_custom_field.name => "", input_custom_field.name => "" }) }
    let(:params) do
      {
          building: {
            client_id: client.id,
            street_address_one: Faker::Address.street_address,
            street_address_two: Faker::Address.secondary_address,
            city: Faker::Address.city,
            state: Faker::Address.state_abbr,
            zipcode: Faker::Address.zip_code

          }
        }
    end

    context "with valid custom fields values" do
      let(:expected_building_attributes) do
        {
          **params[:building].except(
            enum_custom_field.name.to_sym,
            input_custom_field.name.to_sym
          ),
          custom_fields: {
            enum_custom_field.name => enum_custom_field.values.first,
            input_custom_field.name => "0.0"
          }
        }
      end

      before do
        params[:building][enum_custom_field.name.to_sym] = enum_custom_field.values.first
        params[:building][input_custom_field.name.to_sym] = 0.0
      end

      it "updates a building" do
        headers = { "ACCEPT" => "application/json" }
        put "/buildings/#{building.id}", params: params, headers: headers

        expect(response.content_type).to start_with("application/json")
        expect(response).to have_http_status(:ok)
        expect(Building.last).to have_attributes(**expected_building_attributes)
      end
    end

    context "with an invalid custom fields value" do
      before do
        params[:building][enum_custom_field.name.to_sym] = "wrong enum"
        params[:building][input_custom_field.name.to_sym] = 0.0
      end

      it "returns an error" do
        headers = { "ACCEPT" => "application/json" }
        put "/buildings/#{building.id}", params: params, headers: headers

        expect(response.content_type).to start_with("application/json")
        expect(response).to have_http_status(:bad_request)
      end
    end
  end
end
