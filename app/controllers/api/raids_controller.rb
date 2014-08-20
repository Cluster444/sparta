module Api
  class RaidsController < BaseController
    before_action :load_player
    before_action :load_city

    def index
      @raids = @city.raids
    end

    def show
      @raid = @city.raids.find params[:id]
    end

    def create
      @raid = @city.raids.build raid_params.merge(player: @player)

      if @raid.save
        render :show, status: :created, location: [:api, @player, @city, @raid]
      else
        render json: {errors: @raid.errors}, status: :unprocessable_entity
      end
    end

    def update
      @raid = @city.raids.find params[:id]

      if @raid.update raid_params
        render :show, location: [:api, @player, @city, @raid]
      else
        render json: {errors: @raid.errors}, status: :unprocessable_entity
      end
    end

    def destroy
      @raid = @city.raids.find params[:id]
      @raid.destroy!
      render nothing: true, status: :no_content
    end

    private

    def load_player
      @player = Player.find params[:player_id]
    end

    def load_city
      @city = @player.cities.find params[:city_id]
    end

    def raid_params
      params.require(:raid).permit(:timber, :bronze, :food, :capacity, :reported_at)
    end
  end
end
