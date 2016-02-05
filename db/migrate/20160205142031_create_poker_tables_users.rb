class CreatePokerTablesUsers < ActiveRecord::Migration
  def change
    create_table :poker_tables_users do |t|
      t.references :poker_table, index: true, foreign_key: true
      t.references :user, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
