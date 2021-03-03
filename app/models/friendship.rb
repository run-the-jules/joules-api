class Friendship < ApplicationRecord
  validates :user_id, :following_id, presence: true
  attribute :usages

  def self.friends(user_id)
    where('user_id = ?', user_id)
    .pluck(:following_id)
  end
end
