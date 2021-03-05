require 'rails_helper'

describe FriendshipsFacade do 
  it "compare" do 
    user = create(:usage, user_id: 1)
    friend = create(:usage, user_id: 2)
    Friendship.create(user_id: user.user_id, following_id: friend.user_id)
    result = FriendshipsFacade.compare(user.user_id.to_s)
    
    expect(result).to be_a(Friends)
    expect(result).to have_attributes(end_date: user.end_date,
                                      user_id: user.user_id,
                                      user_kwh: user.kwh,
                                      friends_data: [friend_id: friend.user_id, 
                                                    kwh_usage: friend.kwh, 
                                                    end_date: friend.end_date])

  end

  it "sad path" do 
    user = create(:usage, user_id: 1)
    friend_id = 2
    Friendship.create(user_id: user.user_id, following_id: friend_id)
    result = FriendshipsFacade.compare(user.user_id.to_s)
    expect(result).to be_a(Friends)
    expect(result).to have_attributes(end_date: user.end_date,
      user_id: user.user_id,
      user_kwh: user.kwh,
      friends_data: [friend_id: friend_id, 
                    kwh_usage: nil, 
                    end_date: nil])
  end
end