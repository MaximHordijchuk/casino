class PokerTable < ActiveRecord::Base
  has_many :poker_tables_users, dependent: :destroy
  has_many :users, through: :poker_tables_users

  scope :available, -> (n = 6) { where('users_count < ? AND start_time >= ?', n, Time.zone.now) }

  validates :name, uniqueness: { case_sensitive: false }, presence: true
  validates :start_time, presence: true
end
