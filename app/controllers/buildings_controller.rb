class BuildingsController < ApplicationController
  rescue_from Exception, with: :error_handler
  before_action :set_client, only: [ :create, :update ]

  def index
    @page = params[:page]
    @per_page = params[:per_page]

    @buildings = if @page.present? && @per_page.present?
      Building.page(@page).per(@per_page)
    else
      Building.all
    end
  end

  def show
    @building = Building.find(params[:id])
  end

  def create
    @building = Building.new(building_params)

    result = CustomFieldsBuilder.new.call(
      schema: CustomFieldsSchemaBuilder.new.call(@client.custom_fields),
      custom_fields: custom_field_params.to_h
    )

    if result.success?
      @building.custom_fields = result.value!
    else
      result.failure.each { |message| @building.errors.add(:base, message:) }
    end

    if @building.errors.blank? && @building.save
      render :show, status: :created
    else
      render :show, status: :bad_request
    end
  end

  def update
    @building = Building.find_by!(id: params[:id], client_id: building_params[:client_id])
    @building.assign_attributes(building_params)

    result = CustomFieldsBuilder.new.call(
      schema: CustomFieldsSchemaBuilder.new.call(@client.custom_fields),
      custom_fields: custom_field_params.to_h
    )

    if result.success?
      @building.custom_fields = result.value!
    else
      result.failure.each { |message| @building.errors.add(:base, message:) }
    end

    if @building.errors.blank? && @building.save
      render :show, status: :ok
    else
      render :show, status: :bad_request
    end
  end

  private

  def error_handler(exception)
    render json: { message: exception, backtrace: exception.backtrace.join("\n") }, status: :bad_request
  end

  def set_client
    @client = Client.includes(:input_custom_fields, :enum_custom_fields).find(building_params[:client_id])
  end

  def custom_field_params
    params.require(:building).except(:client_id, :street_address_one, :street_address_two, :city, :state, :zipcode).permit!
  end

  def building_params
    params.require(:building).permit(:client_id, :street_address_one, :street_address_two, :city, :state, :zipcode)
  end
end
