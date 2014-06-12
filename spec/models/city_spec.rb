require 'rails_helper'

describe City do
  it 'creates a level progress when setting the level on create' do
    expect { FactoryGirl.create(:city, level: 5.5) }.to change(LevelProgress, :count).by 1
    expect(LevelProgress.last.level).to eq 5.5
  end

  it 'creates a level progress when updating the level' do
    city = FactoryGirl.create(:city, level: 5.5)
    expect { city.update(level: 6.6) }.to change(LevelProgress, :count).by 1
    expect(LevelProgress.last.level).to eq 6.6
  end

  describe 'raid estimate' do
    it 'returns nil if the acropolis is not set' do
      city = FactoryGirl.create(:city)
      expect(city.estimated_raid_resources).to be_nil
    end

    it 'returns nil if the estimated resources is nil' do
      city = FactoryGirl.create(:city, acropolis: 1000)
      expect(city.estimated_raid_resources).to be_nil
    end

    it 'returns the total current resources minus the acropolis' do
      city = FactoryGirl.create(:city, acropolis: 1000)
      FactoryGirl.create(:scout, city: city, timber: 4000, bronze: 5000, food: 6000)
      expect(city.estimated_raid_resources).to eq 12000
    end
  end
end
