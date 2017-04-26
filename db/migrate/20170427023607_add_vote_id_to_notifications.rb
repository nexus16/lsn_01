class AddVoteIdToNotifications < ActiveRecord::Migration[5.0]
  def change
    add_column :notifications, :vote_id, :integer
  end
end
