[City, Player, Raid, Scout, LevelProgress].each &:delete_all

Player.create!(name: 'Player').tap do |player|
  50.times do |n|
    player.cities.create!(name: "City #{n+1}", level: 5, x: 0, y: 0, acropolis: 5000, timber_production: 100, bronze_production: 100, food_production: 100).tap do |city|
      5.times do |s|
        city.scouts.create!(player: player, food: 8000, timber: 8000, bronze: 8000, reported_at: Time.now - (s+1).days)
        city.raids.create!(player: player, food: 3000, timber: 3000, bronze: 3000, capacity: 10000, reported_at: Time.now - ((s+1).days - 1.hour))
      end
    end
  end
end
