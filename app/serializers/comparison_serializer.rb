class ComparisonSerializer
  def self.compare(user_id, friend_ids)
    { data: {
      id: user_id, 
      type: 'user_friends', 
      attributes: {
        user_kwh: Usage.find_by(user_id: user).kwh
        friends: friend_ids.map do |friend|
          {friend =>
            Usage.find_by(user_id: friend).kwh < user_kwh ? "less than" : "greater than"}
            end
            }
      }
    }
  end
end