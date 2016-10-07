class User < ActiveRecord::Base
  has_many :poker_tables_users, dependent: :destroy
  has_many :poker_tables, through: :poker_tables_users

  before_validation :downcase_email
  validates :email, email: true, presence: true, uniqueness: true
  validate :poker_tables_available

  def update_with_merging(params)
    merged_params = params
    merged_params[:poker_table_ids] |= poker_table_ids unless poker_table_ids.empty?
    update(merged_params)
  end

  private

  def downcase_email
    self.email = self.email.downcase
  end

  def poker_tables_available
    poker_tables.each do |poker_table|
      errors.add(:poker_table, "#{poker_table.name} is not available") unless poker_table.available?
    end
  end
end
