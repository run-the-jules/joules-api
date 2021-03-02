require 'rails_helper'

RSpec.describe 'meter activation controller' do 
  it 'returns a referral url when referral params is provided', :vcr do 
    get "/api/v1/meter_activation?referral=186139"
    expect(response.status).to eq(200)
    data = JSON.parse(response.body, symbolize_names: true)
    data[:data].each do |meter|
      expect(meter).to have_key(:meter_uid)
      expect(meter[:meter_uid]).to be_a(String)
    end
    sleep 6
  end

  it 'returns a referral url when email and utility params is provided', :vcr do 
    get "/api/v1/meter_activation?email=test5@gmail.com&utility=ACE"
    expect(response.status).to eq(200)
    expect(response.body).to be_a(String)
    sleep 6
  end

  it 'initates calling for bills if meter uid params is provided', :vcr do 
    usage_count = Usage.all.count
    get "/api/v1/meter_activation?meter_uid=711267"
    data = JSON.parse(response.body, symbolize_names: true)
    expect(response.status).to eq(202)
    expect(data[:message]).to eq('fetching bills')
    expect(Usage.all.count).to eq(usage_count + 14)
    sleep 6
  end
end