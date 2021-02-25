require 'rails_helper'

describe UsagesFacade do
  describe 'utility_info' do
    it 'brings user utility information' do
      usage_stub = File.read("spec/fixtures/usage_data.json")
      stub_request(:get, "https://mysterious-ravine-12345.herokuapp.com/api/v1/users/1/usage").
      to_return(status: 200, body: usage_stub)

      id = 1
      usage = UsagesFacade.utility_info(id)
      expect(usage).to be_a(Usage)
      expect(usage.user_id).to be_a(Numeric)
      expect(usage.kwh).to be_a(Numeric)
      expect(usage.start_date).to be_a(Date)
      expect(usage.end_date).to be_a(Date)
      expect(usage.meter_id).to be_a(String)
    end
  end

end
