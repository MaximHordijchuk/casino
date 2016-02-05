# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
User.destroy_all
PokerTable.destroy_all

User.create! [
    { email: 'vasya@gmail.com' },
    { email: 'anton@mail.ru' },
    { email: 'vlad@i.ua' },
    { email: 'denis1993@yandex.ru' },
    { email: 'demedovich@gmail.com' },
    { email: 'andrey@gmail.com' },
    { email: 'ivan@i.ua' },
             ]

10.times do |i|
  PokerTable.create!({ name: "Poker Table #{i}",
                       start_time: Time.zone.now + rand(5).minutes })
end
PokerTable.create!({ name: "Poker Table 11",
                     start_time: Time.zone.now - 1.minutes})

PokerTable.first.users << User.all.limit(6)
