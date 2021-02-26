require 'rails_helper'

RSpec.describe 'friendship request' do 
  describe "friends' show" do 
    xit "returns friends' monthly points" do 
      usages = create_list(:usage, 5) do |usage, i|
        usage.user_id = (1 + i )
      end
      
    end
  end

  describe "friendship create" do 
    it "posts user id and friend is as a friendship record" do 
      friendship_params = ({user_id:101, following_id:202})
      headers = {"CONTENT_TYPE" => "application/json"}

      post "/api/v1/friendships", headers: headers, params: JSON.generate({friendship: friendship_params})

      created_friendship = Friendship.last

      expect(response.status).to eq(201)
      expect(created_friendship.user_id.to_i).to eq(friendship_params[:user_id])
      expect(created_friendship.following_id.to_i).to eq(friendship_params[:following_id])
    end

    it "error 409 if incorrect friendship_params" do 
      friendship_params = ({user_id:101})
      headers = {"CONTENT_TYPE" => "application/json"}

      post "/api/v1/friendships", headers: headers, params: JSON.generate({friendship: friendship_params})

      created_friendship = Friendship.last

      expect(response.status).to eq(409)
    end
  end
end