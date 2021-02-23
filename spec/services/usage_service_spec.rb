require 'rails_helper'

describe UsageService do
  it 'can make an api call to Sinatra endpoint' do
    usage = create(:usage)
    result = UsageService.kwh_usage("/api/v1/users/#{usage.user_id}/usage")

    expect(result).to be_a(Hash)
  end
end
