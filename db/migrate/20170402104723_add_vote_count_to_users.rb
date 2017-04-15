class AddVoteCountToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :vote_count, :integer, default: 0
  end
end
