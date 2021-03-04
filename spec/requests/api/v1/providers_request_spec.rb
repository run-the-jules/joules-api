require 'rails_helper'

RSpec.describe 'providers api endpoint', type: :request do
  describe '(happy path)', :vcr do
    it 'returns a list of all available providers', :vcr do
      VCR.use_cassette('/Users/kaiheiongaku/turing/mod3/projects/jules_api/spec/fixtures/vcr_cassettes/providers_api_endpoint/_happy_path_/returns_a_list_of_all_available_providers.yml') do
        get '/api/v1/providers'
        expect(response.status).to eq(200)

        json = JSON.parse(response.body, symbolize_names: true)[:data]

        expect(json.count).to eq(29)
        expect(json.first).to have_key(:id)
        expect(json.first[:attributes]).to have_key(:name)
        expect(json.first[:attributes]).to have_key(:id)
      end
    end
  end
  describe 'sad path' do
    it 'returns an error if the path is invalid', :vcr do
      get '/api/v1/pronvider'

      expect(response.status).to eq(404)

      json = JSON.parse(response.body, symbolize_names: true)

      expect(json).to have_key(:error)
    end
  end
end
