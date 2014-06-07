[City, Player, Raid, Scout].each &:delete_all

Player.create!(name: 'Player').tap do |player|
  player.cities.create!(name: 'City 1', x: 0, y: 0).tap do |city|
  end
  player.cities.create!(name: 'City 2', x: 5, y: 5).tap do |city|
  end
end
