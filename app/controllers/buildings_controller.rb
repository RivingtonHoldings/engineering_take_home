class BuildingsController < ApplicationController
  before_action :set_client, only: [ :create, :update ]

  def index
    @buildings = Building.all
  end

  def show
    @building = Building.find(params[:id])
  end

  def create
    @building = Building.new(create_params)

    result = CustomFieldsBuilder.new.call(
      schema: CustomFieldSchemaBuilder.new.call(@client.custom_fields),
      custom_fields: custom_field_params
    )

    if result.success?
      @building.custom_fields = result.value
    else
      result.failure.each { |field_name, message| @building.errors.add(field_name, message:) }
    end

    if @building.save
      render :show, status: :created
    else
      render :show, status: :bad_request
    end
  end

  def update
    @building = Building.find(params[:id])
    @building.assign_attributes(building_params)

    result = CustomFieldsBuilder.new.call(
      schema: CustomFieldSchemaBuilder.new.call(@client.custom_fields),
      custom_fields: custom_field_params
    )

    if result.success?
      @building.custom_fields = result.value
    else
      result.failure.each { |field_name, message| @building.errors.add(field_name, message:) }
    end

    if @building.save
      render :show, status: :ok
    else
      render :show, status: :bad_request
    end
  end

  private

  def set_client
    @client = Client.include(:input_custom_fields, :enum_custom_fields).find(params[:client_id])
  end

  def custom_field_params
    params.require(:building).except!(:client_id, :street_address_one, :street_address_two, :city, :state, :zipcode).permit!
  end

  def create_params
    params.require(:building).permit(:client_id, :street_address_one, :street_address_two, :city, :state, :zipcode)
  end

  def update_params
    params.require(:building).permit(:street_address_one, :street_address_two, :city, :state, :zipcode)
  end
end
