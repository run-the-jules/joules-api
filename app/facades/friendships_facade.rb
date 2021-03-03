class FriendshipsFacade
  class << self 
    def compare(user_id, friend_ids)
      friend_ids.map!(&:to_i)
      user_kwh = Usage.find_by(user_id: user_id).kwh
      Friends.new({user_id: user_id, 
        user_kwh: user_kwh, 
        friends: friend_ids.map do |friend_id|
      {friend_id: friend_id, 
        kwh_usage: Usage.find_by(user_id: friend_id).kwh}
      end
      })
    end
  end
end