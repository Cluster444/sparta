# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :scout do
    city { FactoryGirl.create :city }
    player {|scout| scout.city.player}
    timber 1000
    bronze 1000
    food 1000
    scouted_at { Time.now }
  end
end
