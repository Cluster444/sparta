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

    it 'does not subtract beyond the acropolis value' do
      city = FactoryGirl.create(:city, acropolis: 5000)
      FactoryGirl.create(:scout, city: city, timber: 500, bronze: 5000, food: 6000)
      expect(city.estimated_raid_resources).to eq 1000
    end
  end

  describe 'last battle report time' do
    it 'returns nil if there are no raids or scouts' do
      city = FactoryGirl.create(:city)
      expect(city.last_battle_report_at).to be_nil
    end

    it 'returns the last raid report time when there is no scouts' do
      city = FactoryGirl.create(:city)
      Timecop.freeze Time.parse('06/12/2014 4:00:00') do
        FactoryGirl.create(:raid, city: city, reported_at: Time.now - 2.days)
        FactoryGirl.create(:raid, city: city, reported_at: Time.now - 90.minutes)
        expect(Time.now - city.last_battle_report_at).to eq(90.minutes)
      end
    end

    it 'returns the last scout report time when there is no raids' do
      city = FactoryGirl.create(:city)
      Timecop.freeze Time.parse('06/12/2014 4:00:00') do
        FactoryGirl.create(:scout, city: city, reported_at: Time.now - 2.days)
        FactoryGirl.create(:scout, city: city, reported_at: Time.now - 90.minutes)
        expect(Time.now - city.last_battle_report_at).to eq(90.minutes)
      end
    end

    it 'returns the last raid report when raid is newer than the last scout' do
      city = FactoryGirl.create(:city)
      Timecop.freeze Time.parse('06/12/2014 4:00:00') do
        FactoryGirl.create(:scout, city: city, reported_at: Time.now - 2.days)
        FactoryGirl.create(:raid, city: city, reported_at: Time.now - 90.minutes)
        expect(Time.now - city.last_battle_report_at).to eq(90.minutes)
      end
    end

    it 'returns the last scout report when the scout is newer than the last raid' do
      city = FactoryGirl.create(:city)
      Timecop.freeze Time.parse('06/12/2014 4:00:00') do
        FactoryGirl.create(:raid, city: city, reported_at: Time.now - 2.days)
        FactoryGirl.create(:scout, city: city, reported_at: Time.now - 90.minutes)
        expect(Time.now - city.last_battle_report_at).to eq(90.minutes)
      end
    end
  end
end
