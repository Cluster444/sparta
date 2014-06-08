class RaidsController < ApplicationController
  before_action :set_player
  before_action :set_city
  before_action :set_raid, only: [:show, :edit, :update, :destroy]

  # GET /raids
  # GET /raids.json
  def index
    @raids = @city.raids
  end

  # GET /raids/1
  # GET /raids/1.json
  def show
  end

  # GET /raids/new
  def new
    @raid = @city.raids.build
  end

  # GET /raids/1/edit
  def edit
  end

  # POST /raids
  # POST /raids.json
  def create
    @raid = @city.raids.build(raid_params)
    @raid.player = @player

    respond_to do |format|
      if @raid.save
        format.html { redirect_to [@player, @city], notice: 'Raid was successfully created.' }
        format.json { render :show, status: :created, location: [@player, @city] }
      else
        format.html { render :new }
        format.json { render json: @raid.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /raids/1
  # PATCH/PUT /raids/1.json
  def update
    respond_to do |format|
      if @raid.update(raid_params)
        format.html { redirect_to [@player, @city], notice: 'Raid was successfully updated.' }
        format.json { render :show, status: :ok, location: [@player, @city] }
      else
        format.html { render :edit }
        format.json { render json: @raid.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /raids/1
  # DELETE /raids/1.json
  def destroy
    @raid.destroy
    respond_to do |format|
      format.html { redirect_to [@player, @city], notice: 'Raid was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_raid
      @raid = @city.raids.find(params[:id])
    end

    def set_player
      @player = Player.find(params[:player_id])
    end

    def set_city
      @city = @player.cities.find(params[:city_id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def raid_params
      params.require(:raid).permit(:timber, :bronze, :food, :capacity, :raided_at)
    end
end
