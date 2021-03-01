require 'rails_helper'

RSpec.describe 'usage request' do
  describe 'shows usage information' do
    it 'returns the applicable existing usage data', :vcr do
      user_id = 185072
      # referral = 186139
      # meter_uid = UsageService.get_meters(referral)[:data].first[:meter_uid].to_i
      meter_uid = 711267
      bills = MeterActivationFacade.get_bills(meter_uid)
      
      get "/api/v1/usages/#{user_id}"
      expect(response.status).to eq(200)
      result = JSON.parse(response.body, symbolize_names:true)
      expect(result).to be_a(Hash)
      data = result[:data]
      data.each do |reading|
        expect(reading).to have_key(:type)
        expect(reading).to have_key(:attributes)
        expect(reading[:type]).to eq('usages')
        expect(reading[:attributes][:user_id]).to eq(user_id)
        expect(reading[:attributes]).to have_key(:kwh)
        expect(reading[:attributes]).to have_key(:start_date)
        expect(reading[:attributes]).to have_key(:end_date)
        expect(reading[:attributes]).to have_key(:meter_id)
      end
    end
  end
end
