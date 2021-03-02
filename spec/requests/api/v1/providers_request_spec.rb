require 'rails_helper'

RSpec.describe "providers api endpoint", type: :request do
  describe "(happy path)", :vcr do
    it "returns a list of all available providers", :vcr do

      get "/api/v1/providers"
      expect(response.status).to eq(200)

      json = JSON.parse(response.body, symbolize_names: true)[:data]

      expect(json.count).to eq(29)
      expect(json.first).to have_key(:id)
      expect(json.first[:attributes]).to have_key(:name)
      expect(json.first[:attributes]).to have_key(:id)
    end
  end
end
