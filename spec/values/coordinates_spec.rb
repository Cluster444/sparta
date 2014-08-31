require './app/values/coordinates'

RSpec.describe Coordinates do
  it 'can tell the distance from another set of coordinates' do
    a = Coordinates.new(0,0)
    b = Coordinates.new(3,4)
    expect(a.distance(b)).to eq 5.0
  end
end
