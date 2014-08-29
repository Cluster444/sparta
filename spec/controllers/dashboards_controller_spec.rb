require 'rails_helper'

RSpec.describe DashboardsController, :type => :controller do
  let(:player) { stub_model(Player) }

  before do
    allow(Player).to receive(:find).with(player.id.to_s).and_return(player)
  end

  describe '#raiding' do
    it 'makes a raiding view available for the template' do
      get :raiding, id: player.id

      expect(assigns(:raiding_dashboard)).to be_a RaidingDashboard
    end

    it 'passes the view context and a player to the raiding view' do
      allow(RaidingDashboard).to receive(:new)

      get :raiding, id: player.id

      expect(RaidingDashboard).to have_received(:new).with(player)
    end
  end
end
