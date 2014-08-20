module Api
  class CitiesController < BaseController
    before_action :load_player

    def index
      @cities = @player.cities
    end

    def show
      @city = @player.cities.find params[:id]
    end

    def create
      @city = @player.cities.build city_params

      if @city.save
        render :show, status: :created, location: [:api, @player, @city]
      else
        render json: {errors: @city.errors}, status: :unprocessable_entity
      end
    end

    def update
      @city = @player.cities.find params[:id]

      if @city.update city_params
        render :show, location: [:api, @player, @city]
      else
        render json: {errors: @city.errors}, status: :unprocessable_entity
      end
    end

    def destroy
      @city = @player.cities.find params[:id]

      @city.destroy!
      render nothing: true, status: :no_content
    end

    private

    def load_player
      @player = Player.find params[:player_id]
    end

    def city_params
      params.require(:city).permit(:name, :acropolis, :x, :y,
                                   :timber_production, :bronze_production, :food_production,
                                   :timber_storage, :bronze_storage, :food_storage)
    end
  end
end
