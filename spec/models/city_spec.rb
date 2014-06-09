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
end
