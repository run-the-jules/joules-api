require 'rails_helper'

describe MeterActivationFacade do
  describe 'get_bills' do
    it 'brings user utility information', :vcr do
      user_id = 2
      meter_id = 711267
      usages = MeterActivationFacade.get_bills(meter_id, user_id)
      usages.each do |usage|
        expect(usage).to be_a(Usage)
        expect(usage.user_id).to be_a(Numeric)
        expect(usage.kwh).to be_a(Numeric)
        expect(usage.start_date).to be_a(Date)
        expect(usage.end_date).to be_a(Date)
        expect(usage.meter_id).to be_a(String)
      end
    end

    it "retrieves the record from the database instead of creating it", :vcr do 
      # binding.pry
      usage_count = Usage.all.count
      user_id = 2
      meter_id = 711267
      usages = MeterActivationFacade.get_bills(meter_id, user_id)
      usages.each do |usage|
        expect(usage).to be_a(Usage)
        expect(usage.user_id).to be_a(Numeric)
        expect(usage.kwh).to be_a(Numeric)
        expect(usage.start_date).to be_a(Date)
        expect(usage.end_date).to be_a(Date)
        expect(usage.meter_id).to be_a(String)
      end
      expect(Usage.all.count).to eq(usage_count + 15)
      usages = MeterActivationFacade.get_bills(meter_id, user_id)
      expect(Usage.all.count).to eq(usage_count + 15)
    end
  end

  describe "referral" do 
    it 'returns meter ids if provided a referral number', :vcr do
      params = { referral: 186139 }
      data = MeterActivationFacade.referral(params)
      expect(data).to be_an(Array)
      data.each do |meter|
        expect(meter).to have_key(:meter_uid)
      end
    end
  end

  # describe "parse_meters" do 
  #   it "returns meter usages if there are multiple meters", :vcr do 
  #     user_id = 2
  #     meter_ids = [{:meter_uid=>"711267"}]
  #     usages = MeterActivationFacade.parse_meters(meter_ids, user_id)
  #     usages.each do |usage|
  #       expect(usage).to be_a(Usage)
  #       expect(usage.user_id).to be_a(Numeric)
  #       expect(usage.kwh).to be_a(Numeric)
  #       expect(usage.start_date).to be_a(Date)
  #       expect(usage.end_date).to be_a(Date)
  #       expect(usage.meter_id).to be_a(String)
  #     end
  #   end
  # end

  describe "sad paths" do 
    it 'returns an error when referral params are not present or a number', :vcr do
      params = { referral: 'not a referral' }
      data = MeterActivationFacade.referral(params)
      expect(data).to eq(nil)
    end
    
    it 'returns error if referral is empty', :vcr do
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
