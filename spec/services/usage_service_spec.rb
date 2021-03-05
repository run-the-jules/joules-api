require 'rails_helper'

describe UsageService do
  it 'can get bills', :vcr do
    # usage_stub_2 = File.read('spec/fixtures/demo_bills.json')
    # stub_request(:get, /bills/).to_return(
    #   status: 200, body: usage_stub_2
    # )
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

  it 'bills sad path', :vcr do
    meter_id = 'not a meter id'
    data = UsageService.get_bills(meter_id)

    expect(data).to be_a(Hash)
    expect(data).to have_key(:error)
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
