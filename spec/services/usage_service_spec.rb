require 'rails_helper'

describe UsageService do
  it 'can make an api call to Sinatra endpoint' do
    usage = create(:usage, user_id: 1)

    usage_stub = File.read("spec/fixtures/usage_data.json")
    stub_request(:get, "https://mysterious-ravine-12345.herokuapp.com/api/v1/users/#{usage.user_id}/usage").
         to_return(status: 200, body: usage_stub)

    result = UsageService.kwh_usage("/api/v1/users/#{usage.user_id}/usage")

    expect(result).to be_a(Hash)
    expect(result).to have_key(:user_uid)
    expect(result).to have_key(:readings)
    expect(result).to have_key(:meter_id)
  end
end
