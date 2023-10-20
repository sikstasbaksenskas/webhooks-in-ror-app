require 'minitest/autorun'
require "test_helper"

module Webhooks
  class LocationsControllerTest < ActionDispatch::IntegrationTest
    def setup
      @location_params = { location: { lat: 1, lng: 2 } }
      @auth_headers = { Authorization: http_auth() }
    end

    test "that authorization is not failing with correct credentials" do
      response = OpenStruct.new(success: true)

      mock_create_location(response: response)

      post locations_webhook_path, env: { "RAW_POST_DATA" => @location_params.to_json }, headers: @auth_headers, as: :json
  
      assert_response :created
    end

    test "that authorization is failing with incorrect credentials" do
      auth_headers = { Authorization: http_auth(user: "incorrect", password: "incorrect") }
  
      post locations_webhook_path, env: { "RAW_POST_DATA" => @location_params.to_json }, headers: auth_headers, as: :json
  
      assert_response :unauthorized
    end

    private

    def mock_create_location(response:)
      create_location_mock = Minitest::Mock.new
      create_location_mock.expect(:call, response)

      Locations::CreateLocation.stub(:new, create_location_mock)
    end
  end
end
