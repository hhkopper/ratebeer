class BreweriesController < ApplicationController
  before_action :ensure_that_signed_in, except: [:index, :show, :list]
  before_action :set_brewery, only: [:show, :edit, :update, :destroy]
  before_action :skip_if_cached, only:[:index]

  def skip_if_cached
	@order = params[:order] || 'name'
	return render :index if fragment_exist?('brewerylist')
  end

  def list
  end

  # GET /breweries
  # GET /breweries.json
  def index
    @breweries = Brewery.all
    @active_breweries = Brewery.active
    @retired_breweries = Brewery.retired

    order = params[:order] || 'name'

    session[:sort_order] = session[:sort_order] == 'asc' ? 'desc' : 'asc'

    @active_breweries = brewery_sort(@active_breweries, order)
    @retired_breweries = brewery_sort(@retired_breweries, order)
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
    expire_fragment('brewerylist')
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
    expire_fragment('brewerylist')
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
    expire_fragment('brewerylist')
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

    def brewery_sort(list, order)
	sorting = session[:sort_order]

	return case order
		when 'name' then list.order('name ' + sorting)
		when 'year' then list.order('year ' + sorting)
	end
    end
end
