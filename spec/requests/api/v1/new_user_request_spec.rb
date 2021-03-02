require 'rails_helper'

RSpec.describe 'new user controller' do
  it 'expose end point new user index to return an referral url', :vcr do
    get '/api/v1/new_users?email=test5@gmail.com&utility=ACE'
    expect(response.status).to eq(200)
    expect(response.body).to be_a(String)
    expect(response.body).to match(/https:/)
    expect(response.body).to match(/.com/)
  end

  it 'errors if params are missing', :vcr do
    get '/api/v1/new_users?'
    error = JSON.parse(response.body)
    expect(response.status).to eq(400)
    expect(error['error']).to eq('Must send customer email and utility ID')
  end

  it 'errors if params are not valid', :vcr do
    get '/api/v1/new_users?email=823498&utility=234'
    error = JSON.parse(response.body)
    expect(response.status).to eq(400)
    expect(error['data']['error']).to eq('invalid_utility')
  end
end
