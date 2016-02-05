class PokerTablesUser < ActiveRecord::Base
  belongs_to :poker_table, counter_cache: :users_count
  belongs_to :user
end
