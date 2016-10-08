class User < ActiveRecord::Base
  has_and_belongs_to_many :poker_tables

  before_validation :downcase_email
  validates :email, email: true, presence: true, uniqueness: true
  validate :poker_tables_dont_intersect

  def update_with_merging(params)
    merged_params = params
    if merged_params[:poker_table_ids]
      unless validate_tables_available(merged_params[:poker_table_ids])
        return false
      end
      unless poker_table_ids.empty?
        merged_params[:poker_table_ids] |= poker_table_ids
      end
    end
    update(merged_params)
  end

  private

  def downcase_email
    self.email = self.email.downcase
  end

  def validate_tables_available(poker_table_ids)
    result = true
    PokerTable.where(id: poker_table_ids).each do |poker_table|
      unless poker_table.available?
        errors.add(:poker_table, "#{poker_table.name} is not available")
        result = false
      end
    end
    result
  end

  def poker_tables_dont_intersect
    tables = []
    poker_tables.each do |poker_table|
      tables << { id: poker_table.id,
                  time: poker_table.start_time,
                  name: poker_table.name }
      tables << { id: poker_table.id,
                  time: poker_table.start_time + poker_table.duration.seconds,
                  name: poker_table.name }
    end
    tables.sort! { |a, b| a[:time] <=> b[:time] }
    last = nil
    tables.each do |table|
      if last
        if last[:id] == table[:id]
          last = nil
        else
          errors.add(:poker_table, "#{last[:name]} intersects #{table[:name]}")
          return
        end
      else
        last = table
      end
    end
  end
end
