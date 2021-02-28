require 'rails_helper'

describe UsageService do
  it 'can make an api call to Sinatra endpoint' do
    usage = create(:usage, email: "jlfoxcollis@gmail.com")

    usage_stub = File.read("spec/fixtures/usage_data.json")
    stub_request(:get, "https://joules-microservice.herokuapp.com/new_users?email=#{usage.email}&utility=ACE").
         to_return(status: 200, body: usage_stub)

    result = UsageService.kwh_usage("/new_user?email=#{usage.email}&utility=ACE")

    expect(result).to be_a(Hash)
    expect(result).to have_key(:user_uid)
    expect(result).to have_key(:readings)
    expect(result).to have_key(:meter_id)
  end

  it 'can fetch all utilities' do
    utilities_stub = File.read("spec/fixtures/utilities.json")
    stub_request(:get, "https://joules-microservice.herokuapp.com/utilities").
      to_return(status: 200, body: utilities_stub)

    result = UsageService.fetch_utilities

    expect(result).to be_a(Hash)
    expect(result).to have_key(:data)
    result[:data].each do |utility|
      expect(utility).to have_key(:id)
      expect(utility).to have_key(:utility_name)
    end
  end
end
