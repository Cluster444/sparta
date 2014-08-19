# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :raid do
    city { FactoryGirl.create :city }
    player {|raid| raid.city.player}
    timber 1000
    bronze 1000
    food 1000
    capacity 5000
    reported_at { Time.now }
  end
end
