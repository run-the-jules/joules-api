require 'rails_helper'

RSpec.describe 'usage api' do
  describe 'create a usage model responding to frontend' do
    it 'creates a model' do
      usage = create(:usage, id: 1)

      usage_params = {
        id: 1
      }
      headers = {"CONTENT_TYPE" => "application/json"}

      post "/api/v1/usage", headers: headers, params: JSON.generate({usage: usage_params})

      created_usage = Usage.last

      expect(response.status).to eq 201
      expect(created_usage.user_id).to eq(usage_params[:id])
    end
  end
end
