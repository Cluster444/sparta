class CitiesController < ApplicationController
  before_action :set_player
  before_action :set_city, only: [:show, :edit, :update, :destroy]

  # GET /cities
  # GET /cities.json
  def index
    @cities = @player.cities
  end

  # GET /cities/1
  # GET /cities/1.json
  def show
    @raids = @city.raids.order(raided_at: :desc).decorate
    @scouts = @city.scouts.order(scouted_at: :desc).decorate
  end

  # GET /cities/new
  def new
    @city = @player.cities.build
  end

  # GET /cities/1/edit
  def edit
  end

  # POST /cities
  # POST /cities.json
  def create
    @city = @player.cities.build(city_params)

    respond_to do |format|
      if @city.save
        format.html { redirect_to [@player, @city], notice: 'City was successfully created.' }
        format.json { render :show, status: :created, location: [@player, @city] }
      else
        format.html { render :new }
        format.json { render json: @city.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /cities/1
  # PATCH/PUT /cities/1.json
  def update
    respond_to do |format|
      if @city.update(city_params)
        format.html { redirect_to [@player, @city], notice: 'City was successfully updated.' }
        format.json { render :show, status: :ok, location: [@player, @city] }
      else
        format.html { render :edit }
        format.json { render json: @city.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /cities/1
  # DELETE /cities/1.json
  def destroy
    @city.destroy
    respond_to do |format|
      format.html { redirect_to player_cities_url(@player), notice: 'City was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_city
      @city = @player.cities.find(params[:id])
    end

    def set_player
      @player = Player.find(params[:player_id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def city_params
      params.require(:city).permit(:name, :acropolis, :level, :x, :y,
                                   :timber_production, :bronze_production, :food_production,
                                   :timber_storage, :bronze_storage, :food_storage)
    end
end
