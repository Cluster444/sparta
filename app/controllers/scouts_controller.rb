class ScoutsController < ApplicationController
  before_action :set_player
  before_action :set_city
  before_action :set_scout, only: [:show, :edit, :update, :destroy]

  # GET /scouts
  # GET /scouts.json
  def index
    @scouts = @city.scouts
  end

  # GET /scouts/1
  # GET /scouts/1.json
  def show
  end

  # GET /scouts/new
  def new
    @scout = @city.scouts.build
  end

  # GET /scouts/1/edit
  def edit
  end

  # POST /scouts
  # POST /scouts.json
  def create
    @scout = @city.scouts.build(scout_params)

    respond_to do |format|
      if @scout.save
        format.html { redirect_to [:raiding, @player], notice: 'Scout was successfully created.' }
        format.json { render :show, status: :created, location: [@player, @city] }
      else
        format.html { render :new }
        format.json { render json: @scout.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /scouts/1
  # PATCH/PUT /scouts/1.json
  def update
    respond_to do |format|
      if @scout.update(scout_params)
        format.html { redirect_to [@player, @city], notice: 'Scout was successfully updated.' }
        format.json { render :show, status: :ok, location: [@player, @city] }
      else
        format.html { render :edit }
        format.json { render json: @scout.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /scouts/1
  # DELETE /scouts/1.json
  def destroy
    @scout.destroy
    respond_to do |format|
      format.html { redirect_to [@player, @city], notice: 'Scout was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_scout
      @scout = Scout.find(params[:id])
    end

    def set_player
      @player = Player.find(params[:player_id])
    end

    def set_city
      @city = @player.cities.find(params[:city_id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def scout_params
      params.require(:scout).permit(:timber, :bronze, :food, :reported_at)
    end
end
