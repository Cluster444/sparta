require 'rails_helper'

RSpec.describe Raid do
  context 'when creating a new record' do
    it 'calculates an expiry date' do
      Time.use_zone('Atlantic Time (Canada)') do
        raid1 = create :raid, reported_at: '2014-01-14 19:59:00' # 2014-01-14 23:59:00Z expires 01-21
        raid2 = create :raid, reported_at: '2014-01-14 20:01:00' # 2014-01-15 00:01:00Z expires 01-22

        expect(raid1.expires_at.utc.iso8601).to eq '2014-01-21T00:00:00Z'
        expect(raid2.expires_at.utc.iso8601).to eq '2014-01-22T00:00:00Z'
      end
    end
  end
end
