class FriendshipsFacade
  class << self 
    def compare(user_id)
      friend_ids = Friendship.friends(user_id)
      friend_ids.map!(&:to_i)
      usage = Usage.find_by(user_id: user_id)
      friend_poro(usage, friend_ids)
    end

    private 

    def friend_poro(usage, friend_ids)
      Friends.new({user_id: usage.user_id, 
        user_kwh: usage.kwh,
        end_date: usage.end_date,
        friends: friend_ids.map do |friend_id|
          usage = Usage.find_by(user_id: friend_id)
          if usage
              {friend_id: friend_id, 
              kwh_usage: usage.kwh,
              end_date: usage.end_date}
          else 
            {friend_id: friend_id, 
              kwh_usage: nil,
              end_date: nil}
          end
        end})
    end
  end
end