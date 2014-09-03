class PlayersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_player, except: [:index]

  # GET /players
  # GET /players.json
  def index
    authorize! :index, Player
    @players = Player.all
  end

  # GET /players/1
  # GET /players/1.json
  def show
    authorize! :show, @player
  end

  def raiding
    @cities = @player.cities.includes(:raids, :scouts).decorate
    @cities = @cities.sort {|a,b| a.last_battle_reported_at <=> b.last_battle_reported_at}.reverse
  end

  def positions
  end

  # GET /players/1/edit
  def edit
    authorize! :edit, @player
  end

  # PATCH/PUT /players/1
  # PATCH/PUT /players/1.json
  def update
    authorize! :update, @player

    respond_to do |format|
      if @player.update(player_params)
        format.html { redirect_to @player, notice: 'Player was successfully updated.' }
        format.json { render :show, status: :ok, location: @player }
      else
        format.html { render :edit }
        format.json { render json: @player.errors, status: :unprocessable_entity }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_player
      @player = Player.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def player_params
      params.require(:player).permit(:name, :x, :y)
    end
end
