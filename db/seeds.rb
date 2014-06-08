[City, Player, Raid, Scout].each &:delete_all

Player.create!(name: 'Player').tap do |player|
  player.cities.create!(name: 'City 1', x: 0, y: 0).tap do |city|
    city.raids.create!(player: player, food: 1000, timber: 1000, bronze: 1000, capacity: 5000, raided_at: Time.now - 2.days)
  end
  player.cities.create!(name: 'City 2', x: 5, y: 5).tap do |city|
    city.raids.create!(player: player, food: 1000, timber: 1000, bronze: 1000, capacity: 5000, raided_at: Time.now - 8.days)
  end
end
