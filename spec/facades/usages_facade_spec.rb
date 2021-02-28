require 'rails_helper'

describe MeterActivationFacade do
  describe 'get_bills' do
    it 'brings user utility information', :vcr do
      # usage_stub = File.read("spec/fixtures/usage_data.json")
      # stub_request(:get, "https://joules-microservice.herokuapp.com/api/v1/users/1/usage").
      # to_return(status: 200, body: usage_stub)

      id = 1
      usage = MeterActivationFacade.get_bills(id)
      expect(usage).to be_a(Usage)
      expect(usage.user_id).to be_a(Numeric)
      expect(usage.kwh).to be_a(Numeric)
      expect(usage.start_date).to be_a(Date)
      expect(usage.end_date).to be_a(Date)
      expect(usage.meter_id).to be_a(String)
    end
  end

end
