class CreatePokerTables < ActiveRecord::Migration
  def change
    create_table :poker_tables do |t|
      t.string :name, null: false
      t.datetime :start_time, null: false

      t.timestamps null: false
    end
  end
end
