require 'rails_helper'

RSpec.describe 'new user controller' do
  it 'expose end point new user index to return an referral url', :vcr do 
    get "/api/v1/new_users?email=test5@gmail.com&utility=ACE"
    expect(response.status).to eq(200)
    expect(response.body).to be_a(String)
    expect(response.body).to match(/https:/)
    expect(response.body).to match(/.com/)
  end
end