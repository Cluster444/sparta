class DashboardsController < ApplicationController
  def raiding
    player = Player.find params[:id]

    @cities = player.cities
  end
end
