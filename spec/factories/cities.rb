# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :city do
    player { FactoryGirl.create :player }
    sequence(:name) {|n| "City-#{n}"}
    x 1
    y 1
  end
end
