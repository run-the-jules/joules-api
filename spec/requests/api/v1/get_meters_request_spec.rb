require 'rails_helper'

RSpec.describe 'get meter controller' do
  it 'returns a meter id when referral params is provided' do
    meters = File.read('spec/fixtures/meters.json')
    stub_request(:get, /meters/).to_return(
      status: 200, body: meters
    )

    usage_stub_2 = File.read('spec/fixtures/demo_bills.json')
    stub_request(:get, /bills/).to_return(
      status: 200, body: usage_stub_2
    )


    get '/api/v1/get_meters?referral=186139&id=1'
    expect(response.status).to eq(200)
    data = JSON.parse(response.body, symbolize_names: true)
    expect(data).to have_key(:error)
    expect(data[:error]).to be_a(String)
  end

  it 'sad path' do
    get '/api/v1/get_meters?referral=not_a_referral&id=1'
    expect(response.status).to eq(404)
    data = JSON.parse(response.body, symbolize_names: true)

    expect(data).to be_a(Hash)
    expect(data).to have_key(:error)
  end

  it 'returns an error when referral params are not present or a number' do
    get '/api/v1/get_meters?referral='
    expect(response.status).to eq(404)
    get '/api/v1/get_meters?referral=notareferral'
    expect(response.status).to eq(404)
  end

  it 'returns an error when referral params are not valid' do
    meters = {"data": nil }.to_json
    stub_request(:get, /meters/).to_return(
      status: 200, body: meters
    )
    get '/api/v1/get_meters?referral=23498710283918724'
    expect(response.status).to eq(404)
    expect(response.body).to be_a(String)
    data = JSON.parse(response.body, symbolize_names: true)

    expect(data[:error]).to eq("Something went wrong.  Please try again later.")
  end

  it 'gets rescued' do
    get '/api/v1/get_meters'

    expect(response).to_not be_successful
  end

  it 'gets annoyed with nil bills' do
    meters = File.read('spec/fixtures/meters.json')
    stub_request(:get, /meters/).to_return(
      status: 200, body: meters
      )
    
    usage_stub_2 = File.read('spec/fixtures/demo_bills.json')
    stub_request(:get, /bills/).to_return(
      status: 200, body: usage_stub_2
      )
        
    get '/api/v1/get_meters?referral=186139&id=1'

    expect(response.status).to eq(200)
    data = JSON.parse(response.body, symbolize_names: true)
    expect(data).to have_key(:error)
    expect(data[:error]).to be_a(String)

  end
end