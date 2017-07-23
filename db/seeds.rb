# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


market_type_list = [
  [ "Fixed Price", 1 ],
  [ "Spread", 2 ]
]

market_type_list.each do |type, id|
  MarketType.create( mechanism: type, id: id )
end

market_status_list = [
  [ "Under Construction", 1 ],
  [ "Published", 2 ],
  [ "Complete", 3 ]
]

market_status_list.each do |status, id|
  MarketStatus.create( market_status: status, id: id )
end