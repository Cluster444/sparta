[City, Player, Raid, Scout, LevelProgress].each &:delete_all

Player.create!(name: 'Player').tap do |player|
  player.cities.create!(name: 'City 1', level: 5, x: 0, y: 0, acropolis: 500, timber_production: 100, bronze_production: 100, food_production: 100).tap do |city|
    city.scouts.create!(player: player, food: 1500, timber: 1500, bronze: 1500, scouted_at: Time.now - 3.days)
    city.raids.create!(player: player, food: 1000, timber: 1000, bronze: 1000, capacity: 5000, raided_at: Time.now - 2.days)
  end
  player.cities.create!(name: 'City 2', level: 10, x: 5, y: 5, acropolis: 500, timber_production: 100, bronze_production: 100, food_production: 100).tap do |city|
    city.scouts.create!(player: player, food: 1500, timber: 1500, bronze: 1500, scouted_at: Time.now - 6.days)
    city.raids.create!(player: player, food: 1000, timber: 1000, bronze: 1000, capacity: 5000, raided_at: Time.now - 8.days)
  end
end
