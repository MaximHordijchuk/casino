class PokerTable < ActiveRecord::Base
  has_many :poker_tables_users, dependent: :destroy
  has_many :users, through: :poker_tables_users

  MAX_USERS_COUNT = 6

  scope :available, -> (n = MAX_USERS_COUNT) { where('users_count < ? AND start_time >= ?', n, Time.now) }

  validates :name, uniqueness: { case_sensitive: false }, presence: true
  validates :start_time, presence: true

  def available?
    users_count < MAX_USERS_COUNT && start_time > Time.now
  end
end
