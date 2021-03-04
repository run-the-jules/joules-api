class FriendUsageSerializer
  include FastJsonapi::ObjectSerializer
  attributes :user_id, :end_date, :user_kwh, :friends_data
  set_id { nil}
end
