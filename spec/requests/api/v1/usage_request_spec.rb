require 'rails_helper'

RSpec.describe 'usage request' do
  describe 'shows usage information' do
    it 'returns the applicable existing usage data', :vcr do
      params = {referral: 186139, id: 2}
      # referral = 186139
      meter_uid = MeterActivationFacade.referral(params)
      # meter_uid = 711267
      # bills = MeterActivationFacade.get_bills(meter_uid)
      
      get "/api/v1/usages/#{params[:id]}"

      expect(response.status).to eq(200)
      result = JSON.parse(response.body, symbolize_names:true)
      expect(result).to be_a(Hash)
      data = result[:data]
      data.each do |reading|
        expect(reading).to have_key(:type)
        expect(reading).to have_key(:attributes)
        expect(reading[:type]).to eq('usages')
        expect(reading[:attributes][:user_id]).to eq(params[:id])
        expect(reading[:attributes]).to have_key(:kwh)
        expect(reading[:attributes]).to have_key(:start_date)
        expect(reading[:attributes]).to have_key(:end_date)
        expect(reading[:attributes]).to have_key(:meter_id)
      end
    end

    it 'sad path' do
      get "/api/v1/usages/not_a_user_id"

      expect(response.status).to eq(404)

      result = JSON.parse(response.body, symbolize_names:true)

      expect(result).to be_a(Hash)
      expect(result).to have_key(:error)
    end
  end
end
