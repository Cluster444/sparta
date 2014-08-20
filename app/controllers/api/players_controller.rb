module Api
  class PlayersController < BaseController
    def show
      @player = Player.find params[:id]
    end
  end
end
