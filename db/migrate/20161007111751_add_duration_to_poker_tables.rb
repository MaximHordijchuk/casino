class AddDurationToPokerTables < ActiveRecord::Migration
  def change
    add_column :poker_tables, :duration, :integer
  end
end
