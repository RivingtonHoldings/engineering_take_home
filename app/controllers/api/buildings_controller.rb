module Api
  class BuildingsController < ApplicationController
    def index
      @buildings = Building.all
    end

    def show
      @building = Building.find(params[:id])
    end

    def create
      @building = Building.new(building_params)

      if @building.save
        render :show, status: :created
      else
        render :show, status: :bad_request
      end
    end

    def update
      @building = Building.find(params[:id])

      if @building.update(update_params)
        render :show, status: :ok
      else
        render :show, status: :bad_request
      end
    end

    private

    def create_params
      params.require(:building).permit(:client_id, :street_address_one, :street_address_two, :city, :state, :zipcode, custom_fields: {})
    end

    def update_params
      params.require(:building).permit(:street_address_one, :street_address_two, :city, :state, :zipcode, custom_fields: {})
    end
  end
end
