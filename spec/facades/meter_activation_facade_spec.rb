require 'rails_helper'

describe MeterActivationFacade do
  describe 'get_bills' do
    it 'brings user utility information', :vcr do
      meter_id = 711267
      usages = MeterActivationFacade.get_bills(meter_id)
      usages.each do |usage|
        expect(usage).to be_a(Usage)
        expect(usage.user_id).to be_a(Numeric)
        expect(usage.kwh).to be_a(Numeric)
        expect(usage.start_date).to be_a(Date)
        expect(usage.end_date).to be_a(Date)
        expect(usage.meter_id).to be_a(String)
      end
    end
  end

  describe 'authorize a user to activate meters' do 
    it "returns a referral url if provided email and utilty", :vcr do 
      params = {email: "test5@gmail.com", utility: "ACE"}
      data = MeterActivationFacade.new_user(params)
      #is there a check for the expetation to be an url?
      expect(data).to be_a(String)
      expect(data).to match(/https:/)
      expect(data).to match(/.com/)
    end

    it "returns meter ids if provided a referral number", :vcr do 
      params = {referral: 186139}
      data = MeterActivationFacade.referral(params)
      expect(data).to be_an(Array)
      data.each do |meter|
        expect(meter).to have_key(:meter_uid)
      end
    end
  end
end
