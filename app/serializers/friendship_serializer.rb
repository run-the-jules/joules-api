class FriendshipSerializer
  include FastJsonapi::ObjectSerializer
  attributes :user_id, :following_id
end
