require 'spec_helper'
require './app/classes/resource_estimator'

describe ResourceEstimator do
  it 'returns nil if the city has no scout or raid reports' do
    city = double('City', raids: [], scouts: [])

    [:bronze, :timber, :food].each do |resource|
      estimator = ResourceEstimator.new(city, resource)
      expect(estimator.estimate).to be_nil
    end
  end

  it 'returns nil if there is a raid report with no acropolis' do
    raid = double('Raid', raided_at: Time.now)
    city = double('City', acropolis: nil, raids: [raid], scouts: [], timber_production: nil, bronze_production: nil, food_production: nil)

    [:bronze, :timber, :food].each do |resource|
      estimator = ResourceEstimator.new(city, resource)
      expect(estimator.estimate).to be_nil
    end
  end

  it 'returns the value of the last scout report with no raid reports' do
    scout = double('Scout', scouted_at: Time.now, timber: 3000, bronze: 4000, food: 5000)
    city = double('City', raids: [], scouts: [scout], timber_production: nil, bronze_production: nil, food_production: nil, timber_storage: 50000, bronze_storage: 50000, food_storage: 50000)

    [:bronze, :timber, :food].each do |resource|
      estimator = ResourceEstimator.new(city, resource)
      expect(estimator.estimate).to eq scout.send(resource)
    end
  end

  it 'returns nil if there is a raid after the last scout without an acropolis value' do
    raid = double('Raid', raided_at: Time.now, at_capacity?: false)
    scout = double('Scout', scouted_at: Time.now - 1.hour, timber: 1, bronze: 2, food: 3)
    city = double('City', acropolis: nil, raids: [raid], scouts: [scout], timber_production: nil, bronze_production: nil, food_production: nil)

    [:bronze, :timber, :food].each do |resource|
      estimator = ResourceEstimator.new(city, resource)
      expect(estimator.estimate).to be_nil
    end
  end

  it 'returns the acropolis value if there was a raid after the last scout and acropolis is set' do
    raid = double('Raid', raided_at: Time.now, at_capacity?: false)
    scout = double('Scout', scouted_at: Time.now - 1.hour, timber: 1, bronze: 2, food: 3)
    city = double('City', acropolis: 3000, raids: [raid], scouts: [scout], timber_production: nil, bronze_production: nil, food_production: nil, timber_storage: 50000, bronze_storage: 50000, food_storage: 50000)

    [:bronze, :timber, :food].each do |resource|
      estimator = ResourceEstimator.new(city, resource)
      expect(estimator.estimate).to eq 3000
    end
  end

  it 'returns the adjusted value from the last scout report when production values are set' do
    scout = double('Scout', scouted_at: Time.now - 90.minutes, timber: 1000, bronze: 2000, food: 3000)
    city = double('City', raids: [], scouts: [scout], timber_production: 100, bronze_production: 200, food_production: 300, timber_storage: 50000, bronze_storage: 50000, food_storage: 50000)

    [:bronze, :timber, :food].each do |resource|
      estimator = ResourceEstimator.new(city, resource)
      expected_resources = (scout.send(resource) + city.send("#{resource}_production") * 1.5).to_i
      expect(estimator.estimate).to eq(expected_resources)
    end
  end

  it 'returns the adjusted value from the last raid report with production and acropolis set' do
    raid = double('Raid', raided_at: Time.now - 90.minutes, at_capacity?: false)
    city = double('City', acropolis: 2000, raids: [raid], scouts: [], timber_production: 100, bronze_production: 200, food_production: 300, timber_storage: 50000, bronze_storage: 50000, food_storage: 50000)

    [:bronze, :timber, :food].each do |resource|
      estimator = ResourceEstimator.new(city, resource)
      expected_resources = (2000 + city.send("#{resource}_production") * 1.5).to_i
      expect(estimator.estimate).to eq(expected_resources)
    end
  end

  it 'returns nil if the last raid hit capacity and no previoius scout report' do
    raid = double('Raid', raided_at: Time.now, at_capacity?: true, timber: 9500, bronze: 9500, food: 9500)
    city = double('City', acropolis: nil, raids: [raid], scouts: [], timber_production: nil, bronze_production: nil, food_production: nil)

    [:bronze, :timber, :food].each do |resource|
      estimator = ResourceEstimator.new(city, resource)
      expect(estimator.estimate).to be_nil
    end
  end

  it 'returns the difference between the previous scout and current raid report when at capacity' do
    scout = double('Scout', scouted_at: Time.now - 2.hour, timber: 15000, bronze: 15000, food: 15000)
    raid = double('Raid', raided_at: Time.now - 1.hour, at_capacity?: true, timber: 9500, bronze: 9500, food: 9500)
    city = double('City', acropolis: nil, raids: [raid], scouts: [scout], timber_production: 100, bronze_production: 100, food_production: 100, timber_storage: 50000, bronze_storage: 50000, food_storage: 50000)

    [:bronze, :timber, :food].each do |resource|
      estimator = ResourceEstimator.new(city, resource)
      expect(estimator.estimate).to eq 5200
    end
  end

  it 'returns the storage cap if the production overflows it' do
    scout = double('Scout', scouted_at: Time.now - 12.hours, timber: 1000, bronze: 1000, food: 1000)
    city = double('City', raids: [], scouts: [scout], timber_production: 100, bronze_production: 100, food_production: 100, timber_storage: 2000, bronze_storage: 2000, food_storage: 2000)

    [:bronze, :timber, :food].each do |resource|
      estimator = ResourceEstimator.new(city, resource)
      expect(estimator.estimate).to eq 2000
    end
  end
end
