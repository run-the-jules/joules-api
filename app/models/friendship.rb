class Friendship < ApplicationRecord
  validates :user_id, :following_id, presence: true
  validates_uniqueness_of :following_id, scope: :user_id
    
  def self.friends(user_id)
    where('user_id = ?', user_id)
    .pluck(:following_id)
  end
end
