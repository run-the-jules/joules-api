require 'rails_helper'

describe UsagesFacade do
  describe 'utility_info' do
    it 'brings user utility information' do
      usage = create(:usage, id: 1)
      data = UsagesFacade.utility_info(usage.id)

      expect(data).to be_a(Hash)
      expect(data[:id]).to be_a(String)
      expect(data[:attributes]).to be_an(Array)
    end
  end

end
