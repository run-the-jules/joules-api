require 'rails_helper'

describe UsageService do
  it 'can fetch all utilities', :vcr do
    result = UsageService.fetch_utilities
    expect(result).to be_a(Hash)
    expect(result).to have_key(:data)
    data = result[:data]
    data.each do |utility|
      expect(utility).to have_key(:id)
      expect(utility).to have_key(:utility_name)
    end
    sleep 6
  end

  it 'can get bills', :vcr do
    meter_id = 711267
    data = UsageService.get_bills(meter_id)[:data]
    data.each do |cycle|
      expect(cycle).to have_key(:start_date)
      expect(cycle).to have_key(:end_date)
      expect(cycle).to have_key(:kwh)
      expect(cycle).to have_key(:meter_uid)
      expect(cycle).to have_key(:user_uid)

      expect(cycle[:start_date]).to be_a(String)
      expect(cycle[:end_date]).to be_a(String)
      expect(cycle[:kwh]).to be_a(Float)
      expect(cycle[:meter_uid]).to be_a(String)
      expect(cycle[:user_uid]).to be_a(Numeric)
    end
    sleep 6
  end

  it "can retrieve a referral url when submitting a form for a new user", :vcr do 
    #this test will have to change when Ian's UtilityAPI account is setup
    params = {email: "test5@gmail.com", utility: 'ACE'}
    data = UsageService.new_user(params)[:data]
    expect(data).to have_key(:url)
    expect(data).to have_key(:user_uid)
    sleep 6
  end

  it "with the referral url, we can get customer's meter uid", :vcr do 
    referral = 186139
    data = UsageService.get_meters(referral)[:data]
    expect(data).to be_an(Array)
    data.each do |meter|
      expect(meter).to have_key(:meter_uid)
    end
    sleep 6
  end
end
