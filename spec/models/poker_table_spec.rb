require 'rails_helper'

RSpec.describe PokerTable, type: :model do
  describe 'available' do
    it 'returns available tables' do
      PokerTable.available.each { |table| expect(table.available?).to be_truthy }
    end
  end
end
