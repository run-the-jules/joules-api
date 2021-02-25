class CreateFriendships < ActiveRecord::Migration[5.2]
  def change
    create_table :friendships do |t|
      t.string :user_id
      t.string :following_id

      t.timestamps
    end
  end
end
