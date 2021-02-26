require 'rails_helper'

RSpec.describe "providers api endpoint", type: :request do
  describe "(happy path)" do
    it "returns a list of all available providers" do
      
      providers_stub = File.read("spec/fixtures/providers_data.json")
      stub_request(:get, "https://mysterious-ravine-12345.herokuapp.com/utilities").to_return(status: 200, body: providers_stub)

      get "/api/v1/providers"
      expect(response.status).to eq(200)
      
      json = json.parse(response.body, symbolize_names: true)
      require 'pry'; binding.pry
    end
  end
end