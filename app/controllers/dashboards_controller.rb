class DashboardsController < ApplicationController
  def raiding
    player = Player.find params[:id]

    @raiding_view = RaidingView.new(player)
  end
end
