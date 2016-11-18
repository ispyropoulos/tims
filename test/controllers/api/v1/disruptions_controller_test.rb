require 'test_helper'

class Api::V1::DisruptionsControllerTest < ActionDispatch::IntegrationTest
  describe 'GET#index' do
    before do
      get api_v1_disruptions_url
    end

    it 'should respond with status 200' do
      response.status.must_equal 200
    end

    it 'should return an empty JSON response' do
      response.body.must_equal({}.to_json)
    end
  end
end
