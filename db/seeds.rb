User.destroy_all
PokerTable.destroy_all

PokerTable.create! [
  { name: 'Available Table 1', start_time: Time.now + 100.day, duration: 1.hour },
  { name: 'Available Table 2', start_time: Time.now + 300.day, duration: 1.hour },
  { name: 'Unavailable Table 1', start_time: 1.day.ago, duration: 1.hour },
  { name: 'Unavailable Table 2', start_time: 2.days.ago, duration: 1.hour },
  { name: 'Intersected Table 1', start_time: Time.now + 500.days, duration: 1.hour },
  { name: 'Intersected Table 2', start_time: Time.now + 500.days - 30.minutes, duration: 1.hour },
]

User.create! [
  { email: 'user_without_tables@mail.ru' },
  { email: 'user_with_tables@mail.ru', poker_tables: [PokerTable.find_by_name('Available Table 1')] },
  { email: 'user_with_intersected_table@mail.ru', poker_tables: [PokerTable.find_by_name('Intersected Table 1')] },
  { email: 'user_with_unavailable_table@mail.ru', poker_tables: [PokerTable.find_by_name('Unavailable Table 1')] }
]