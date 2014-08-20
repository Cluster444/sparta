module Api
  class ScoutsController < BaseController
    before_action :load_player
    before_action :load_city

    def index
      @scouts = @city.scouts
    end

    def show
      @scout = @city.scouts.find params[:id]
    end

    def create
      @scout = @city.scouts.build scout_params

      if @scout.save
        render :show, status: :created, location: [:api, @player, @city, @scout]
      else
        render json: {errors: @scout.errors}, status: :unprocessable_entity
      end
    end

    def update
      @scout = @city.scouts.find params[:id]

      if @scout.update scout_params
        render :show, location: [:api, @player, @city, @scout]
      else
        render json: {errors: @scout.errors}, status: :unprocessable_entity
      end
    end

    def destroy
      @scout = @city.scouts.find params[:id]
      @scout.destroy!
      render nothing: true, status: :no_content
    end

    private

    def load_player
      @player = Player.find params[:player_id]
    end

    def load_city
      @city = @player.cities.find params[:city_id]
    end

    def scout_params
      params.require(:scout).permit(:timber, :bronze, :food, :reported_at)
    end
  end
end
