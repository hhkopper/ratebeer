class BreweriesController < ApplicationController
  before_action :ensure_that_signed_in, except: [:index, :show]
  before_action :set_brewery, only: [:show, :edit, :update, :destroy]

  # GET /breweries
  # GET /breweries.json
  def index
    @active_breweries = Brewery.active
    @retired_breweries = Brewery.retired

    order = params[:order] || 'name'

    if session[:sorted_by].nil?
	session[:sorted_by] = "asc"
    end

    if session[:sorted_by] == "asc"
    	sort_normal(order)
    else
	sort_reverse(order)
    end
  end

  # GET /breweries/1
  # GET /breweries/1.json
  def show
  end

  # GET /breweries/new
  def new
    @brewery = Brewery.new
  end

  # GET /breweries/1/edit
  def edit
  end

  # POST /breweries
  # POST /breweries.json
  def create
    @brewery = Brewery.new(brewery_params)

    respond_to do |format|
      if @brewery.save
        format.html { redirect_to @brewery, notice: 'Brewery was successfully created.' }
        format.json { render action: 'show', status: :created, location: @brewery }
      else
        format.html { render action: 'new' }
        format.json { render json: @brewery.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /breweries/1
  # PATCH/PUT /breweries/1.json
  def update
    respond_to do |format|
      if @brewery.update(brewery_params)
        format.html { redirect_to @brewery, notice: 'Brewery was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @brewery.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /breweries/1
  # DELETE /breweries/1.json
  def destroy
    @brewery.destroy
    respond_to do |format|
      format.html { redirect_to breweries_url }
      format.json { head :no_content }
    end
  end

  def toggle_activity
	brewery = Brewery.find(params[:id])
	brewery.update_attribute :active, (not brewery.active)

	new_status = brewery.active? ? "active" : "retired"

	redirect_to :back, notice:"brewery activity status changed to #{new_status}"
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_brewery
      @brewery = Brewery.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def brewery_params
      params.require(:brewery).permit(:name, :year, :active)
    end

    def sort_reverse(order)
	session[:sorted_by] = "asc"
	@active_breweries = case order
		when 'name' then @active_breweries.sort_by{ |b| b.name }.reverse
		when 'year' then @active_breweries.sort_by{ |b| b.year }.reverse	
    	end
	@retired_breweries = case order
		when 'name' then @retired_breweries.sort_by{ |b| b.name }.reverse
		when 'year' then @retired_breweries.sort_by{ |b| b.year }.reverse	
    	end
    end

    def sort_normal(order)
	@active_breweries = case order
		when 'name' then @active_breweries.sort_by{ |b| b.name }
		when 'year' then @active_breweries.sort_by{ |b| b.year }	
    	end
	@retired_breweries = case order
		when 'name' then @retired_breweries.sort_by{ |b| b.name }
		when 'year' then @retired_breweries.sort_by{ |b| b.year }	
    	end
	session[:sorted_by] = "desc"
    end
end
