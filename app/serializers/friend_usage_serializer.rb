class FriendUsageSerializer
  include FastJsonapi::ObjectSerializer
  attributes :user_id, :user_kwh, :friends_data
  set_id { nil}
end
