class BuildingsController < ApplicationController
  def index
  end

  def create
    building = Building.new(building_params)

    if building.save
      render jsonapi: building
    else
      render jsonapi_errors: building
    end
  end

  def update
    building = Building.find_by!(id: params[:id], client_id: params[:client_id])

    if building.save
      render jsonapi: building
    else
      render jsonapi_errors: building
    end
  end

  private

  def building_params
    params.require(:building).permit(:client_id, :street_address_one, :street_address_two, :city, :state, :zipcode, :custom_fields)
  end
end
