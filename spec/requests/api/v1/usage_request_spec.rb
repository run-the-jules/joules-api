require 'rails_helper'

RSpec.describe 'usage api' do
  describe 'shows usage information' do
    it 'returns the applicable existing usage data' do
      usage_stub = File.read("spec/fixtures/usage_data.json")
      stub_request(:get, "https://mysterious-ravine-12345.herokuapp.com/api/v1/users/1/usage").
      to_return(status: 200, body: usage_stub)
      
      id = 1

      get "/api/v1/usages/#{id}"
      expect(response.status).to eq(200)
      data = JSON.parse(response.body, symbolize_names:true)[:data]

      expect(data).to have_key(:id)
      expect(data).to have_key(:type)
      expect(data).to have_key(:attributes)
      expect(data[:type]).to eq('usages')
      expect(data[:attributes][:user_id]).to eq(id)
      expect(data[:attributes]).to have_key(:kwh)
      expect(data[:attributes]).to have_key(:start_date)
      expect(data[:attributes]).to have_key(:end_date)
      expect(data[:attributes]).to have_key(:meter_id)
    end
  end
end
