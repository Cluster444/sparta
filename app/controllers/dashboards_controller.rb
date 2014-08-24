class DashboardsController < ApplicationController
  def raiding
    player = Player.find params[:id]

    @cities = player.cities
    @view = RaidingView.new(view_context)
  end
end
