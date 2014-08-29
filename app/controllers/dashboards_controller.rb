class DashboardsController < ApplicationController
  def raiding
    player = Player.find params[:id]

    @raiding_dashboard = RaidingDashboard.new(player)
  end
end
