class FriendshipsFacade
  class << self 
    def compare(user_id)
      friend_ids = Friendship.friends(user_id)
      friend_ids.map!(&:to_i)
      usage = Usage.find_by(user_id: user_id)
      Friends.new({user_id: usage.user_id, 
        user_kwh: usage.kwh,
        end_date: usage.end_date,
        friends: friend_ids.map do |friend_id|
          usage = Usage.find_by(user_id: friend_id)
      {friend_id: usage.user_id, 
        kwh_usage: usage.kwh,
        end_date: usage.end_date}
      end
      })
    end
  end
end