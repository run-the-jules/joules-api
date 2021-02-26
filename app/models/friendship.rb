class Friendship < ApplicationRecord
  validates :user_id, :following_id, presence: true
end
