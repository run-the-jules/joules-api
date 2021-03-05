require 'rails_helper'

RSpec.describe 'friendship request' do
  describe "friends' index" do
    it "returns user friends' ids" do
      create_list(:usage, 6) do |usage, i|
        usage.update(user_id: i + 1)
      end
      users = create_list(:friendship, 5, user_id: 1)
      user_id = users[0].user_id
      friend_ids = users[0..-1].map { |friendship| friendship.following_id }
      get '/api/v1/friendships', params: { user_id: user_id }
      expect(response.status).to eq(200)
      data = JSON.parse(response.body, symbolize_names:true)[:data]
      expect(data[:type]).to eq("friend_usage")
      expect(data[:attributes][:user_id]).to eq(user_id.to_i)

      expect(data[:attributes]).to have_key(:user_kwh)
      data[:attributes][:friends_data].each do |friend, _idx|
        expect(friend).to have_key(:friend_id)
        expect(friend).to have_key(:kwh_usage)
      end
    end
  end

  describe 'friendship show' do 
    it "returns friendship data with user id and friend ids" do 
      users = create_list(:friendship, 5, user_id: 1)
      user_id = users[0].user_id
      friend_ids = users[0..-1].map { |friendship| friendship.following_id }
      get '/api/v1/friendships/1', params: { user_id: user_id }
      expect(response.status).to eq(200)
      data = JSON.parse(response.body, symbolize_names: true)[:data]
      data.each do |friendship|
        expect(friendship[:type]).to eq("friendship")
        expect(friendship[:attributes][:user_id]).to eq(user_id)
        expect(friendship[:attributes][:following_id]).to be_a(String)
      end
    end
  end

  describe 'friendship create' do
    it 'posts user id and friend is as a friendship record' do
      friendship_params = { user_id: 101, following_id: 202 }
      headers = { 'CONTENT_TYPE' => 'application/json' }

      post '/api/v1/friendships', headers: headers, params: JSON.generate({ friendship: friendship_params })
      created_friendship = Friendship.last

      expect(response.status).to eq(201)
      expect(created_friendship.user_id.to_i).to eq(friendship_params[:user_id])
      expect(created_friendship.following_id.to_i).to eq(friendship_params[:following_id])
    end

    it 'error 409 if incorrect friendship_params' do
      friendship_params = { user_id: 101 }
      headers = { 'CONTENT_TYPE' => 'application/json' }

      post '/api/v1/friendships', headers: headers, params: JSON.generate({ friendship: friendship_params })

      created_friendship = Friendship.last

      expect(response.status).to eq(409)
    end

    it 'errors if friendship params are missing' do
      create_list(:usage, 6) do |usage, i|
        usage.update(user_id: i + 1)
      end
      users = create_list(:friendship, 5, user_id: 1)
      user_id = users[0].user_id
      friend_ids = users[0..-1].map { |friendship| friendship.following_id }
      get '/api/v1/friendships', params: {}

      expect(response.status).to eq(404)
      error = JSON.parse(response.body)
      expect(error['error']).to eq('User id missing')
    end
  end
end
