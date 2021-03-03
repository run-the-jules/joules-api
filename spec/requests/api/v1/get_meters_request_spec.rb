require 'rails_helper'

RSpec.describe 'get meter controller' do
  it 'returns a meter id when referral params is provided', :vcr do
    get "/api/v1/get_meters?referral=186139"
    expect(response.status).to eq(200)
    data = JSON.parse(response.body, symbolize_names: true)
    data.each do |meter|
      expect(meter).to have_key(:meter_uid)
      expect(meter[:meter_uid]).to be_a(String)
    end
  end

  it 'sad path' do
    get "/api/v1/get_meters?referral=not_a_referral"
    expect(response.status).to eq(404)
    data = JSON.parse(response.body, symbolize_names: true)

    expect(data).to be_a(Hash)
    expect(data).to have_key(:error)
  end
end
