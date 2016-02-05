class AddUsersCountToPokerTable < ActiveRecord::Migration
  def change
    add_column :poker_tables, :users_count, :integer, default: 0, null: false
  end
end
