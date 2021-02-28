class Usage < ApplicationRecord
  def self.compare_usage(user_id, friend_ids)
    joins(:friendships)
    .select()
  end
end
