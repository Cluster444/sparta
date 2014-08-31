require 'spec_helper'
require 'active_support'
require 'action_view'
require './app/helpers/application_helper.rb'

include ApplicationHelper
include ActionView::Helpers::TextHelper

RSpec.describe ApplicationHelper do
  describe '#time_ago' do
    it 'returns the number of minutes for times less than an hour' do
      time = Time.now - 35.minutes
      expect(time_ago(time)).to eq("35 minutes")
    end

    it 'returns the number of hours for times less than a day' do
      time = Time.now - 7.hours
      expect(time_ago(time)).to eq("7 hours")
    end

    it 'returns the days and hours for times greater than a day' do
      time = Time.now - 38.hours
      expect(time_ago(time)).to eq("1 day 14 hours")
    end
  end
end
