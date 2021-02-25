require 'rails_helper'

RSpec.describe 'usage api' do
  describe 'shows usage information' do
    it 'returns the applicable existing usage data' do

      id = 1
      headers = {"CONTENT_TYPE" => "application/json"}

      get "/api/v1/usages/#{id}", headers: headers, params: JSON.generate({usage: id})

      data = JSON.parse(response.body)

      expect(response.status).to eq(200)
      expect(data[:user_id]).to eq(id)


    end
  end
end
