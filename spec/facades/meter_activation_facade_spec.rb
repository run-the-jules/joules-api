require 'rails_helper'

describe MeterActivationFacade do
  describe 'get_bills' do
    it 'brings user utility information', :vcr do
      meter_id = 711_267
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

    it 'returns meter ids if provided a referral number', :vcr do
      params = { referral: 186_139 }
      data = MeterActivationFacade.referral(params)
      expect(data).to be_an(Array)
      data.each do |meter|
        expect(meter).to have_key(:meter_uid)
      end
    end

    it 'returns an error when referral params are not present or a number', :vcr do
      params = { referral: 'not a referral' }
      data = MeterActivationFacade.referral(params)
      expect(data).to eq(nil)

      params = { referral: '' }
      data = MeterActivationFacade.referral(params)
      expect(data).to eq(nil)
    end

    it 'returns an error when referral params are not valid', :vcr do
      params = { referral: 1_232_349_127_384 }
      data = MeterActivationFacade.referral(params)
      expect(data).to eq(nil)
    end
  end
end
