class PokerTable < ActiveRecord::Base
  has_and_belongs_to_many :users

  MAX_USERS_COUNT = 6

  scope :available, -> (n = MAX_USERS_COUNT) { where('users_count < ? AND start_time >= ?', n, Time.now) }

  validates :name, uniqueness: { case_sensitive: false }, presence: true
  validates :start_time, presence: true
  validates :duration, numericality: { greater_than: 0 }

  def available?
    users_count < MAX_USERS_COUNT && start_time > Time.now
  end
end
