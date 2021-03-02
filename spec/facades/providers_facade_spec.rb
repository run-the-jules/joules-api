require 'rails_helper'

describe MeterActivationFacade do
  describe 'get providers' do
    it 'gets the providers information', :vcr do
      providers = ProvidersFacade.get_providers
      expect(providers).to be_an(Array)
      expect(providers.first.id).to be_a(String)
      expect(providers.first.name).to be_a(String)
    end
  end
end
