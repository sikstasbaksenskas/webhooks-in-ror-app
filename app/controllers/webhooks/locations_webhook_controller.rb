module Webhooks
  class LocationsWebhookController < ApplicationController
    include HttpAuthConcern

    before_action :http_basic_auth, only: :webhook
  
    def webhook
      response = Locations::CreateLocation.new(location_params).call
  
      if response.success
        head :created
      else
        render json: { errors: response.message }, status: :unprocessable_entity
      end
    end
  
    private
  
    def location_params
      @request_params = ActionController::Parameters.new(JSON.parse(request.body.read))
  
      @request_params.require(:location).permit(:lat, :lng)
    end
  end
end
