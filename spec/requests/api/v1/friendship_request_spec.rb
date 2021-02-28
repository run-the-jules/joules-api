require 'rails_helper'

RSpec.describe 'friendship request' do 
  describe "friends' index" do 
    it "returns friends' monthly points" do 
      usages = create_list(:usage, 5) do |usage, i|
        usage.update(user_id: (1 + i ))
      end
      user_id = usages[0].user_id
      friend_ids = usages[1..-1].map { |usage| usage.user_id}

      get '/api/v1/friendships', params: {id: user_id, friend_ids: friend_ids}
      expect(response.status).to eq(200)
      data = JSON.parse(response.body, symbolize_names:true)

      # expect(data).to have_key(:id)
      # expect(data).to have_key(:type)
      expect(data).to have_key(:attributes)
      expect(data[:attributes][:user_id]).to eq(user_id)
      expect(data[:attributes][:monthly_points]).to eq(Numeric)
      expect(data[:attributes][:friends]).to be_an(Hash) 
      # user_usage = Usage.find_by(user_id: user_id)
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