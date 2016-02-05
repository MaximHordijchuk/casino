class User < ActiveRecord::Base
  has_many :poker_tables_users, dependent: :destroy
  has_many :poker_tables, through: :poker_tables_users

  before_validation :downcase_email
  validates :email, email: true, presence: true, uniqueness: true

  private

  def downcase_email
    self.email = self.email.downcase
  end
end
