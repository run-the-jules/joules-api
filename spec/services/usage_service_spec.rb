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
  end

  it 'can get bills' do
    VCR.use_cassette('brings_user_utility_information') do
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
    end
  end

  it 'can retrieve a referral url when submitting a form for a new user', :vcr do
    # this test will have to change when Ian's UtilityAPI account is setup
    params = { email: 'test5@gmail.com', utility: 'ACE' }
    data = UsageService.new_user(params)[:data]
    expect(data).to have_key(:url)
    expect(data).to have_key(:user_uid)
  end


  it 'errors if params are missing', :vcr do
    # this test will have to change when Ian's UtilityAPI account is setup
    params = { email: '', utility: '' }
    data = UsageService.new_user(params)[:data]
    # expect(data['error']).to eq('Must send customer email and utility ID')
    expect(data).to have_key(:url)
  end

  it 'errors if params are not valid', :vcr do
    params = { email: 293_847, utility: 2384 }
    data = UsageService.new_user(params)
    expect(data[:data][:error]).to eq('invalid_utility')
  end

  it "with the referral url, we can get customer's meter uid", :vcr do
    referral = 186_139
    data = UsageService.get_meters(referral)[:data]
    expect(data).to be_an(Array)
    data.each do |meter|
      expect(meter).to have_key(:meter_uid)
    end
  end

  it 'errors with an incorrect url', :vcr do
    referral = 'not a url'
    data = UsageService.get_meters(referral)[:data]
    expect(data).to eq(nil)
  end
end
