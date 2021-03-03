require 'rails_helper'

RSpec.describe 'get meter controller' do
  it 'returns a meter id when referral params is provided', :vcr do
    get '/api/v1/get_meters?referral=186139'
    expect(response.status).to eq(200)
    data = JSON.parse(response.body, symbolize_names: true)
    data.each do |meter|
      expect(meter).to have_key(:meter_uid)
      expect(meter[:meter_uid]).to be_a(String)
    end
  end

  it 'returns an error when referral params are not present or a number', :vcr do
    get '/api/v1/get_meters?referral='
    expect(response.status).to eq(400)
    get '/api/v1/get_meters?referral=notareferral'
    expect(response.status).to eq(400)
  end

  it 'returns an error when referral params are not valid', :vcr do
    get '/api/v1/get_meters?referral=23498710283918724'
    expect(response.status).to eq(200)
    expect(response.body).to be_a(String)
    expect(response.body).to eq('null')
  end
end
