class User < ActiveRecord::Base
  has_and_belongs_to_many :poker_tables

  before_validation :downcase_email
  validates :email, email: true, presence: true, uniqueness: true

  private

  def downcase_email
    self.email = self.email.downcase
  end
end
