class ListingsController < ApplicationController
  before_action :listing_params, only: [:create, :update]
  before_action :set_listing, only: [:show, :edit, :update, :destroy]

  # GET /listings
  # GET /listings.json
  def index
    @listings = Listing.all
  end

  # GET /listings/1
  # GET /listings/1.json
  def show
    @images = @listing.images
  end

  # GET /listings/new
  def new
    @listing = Listing.new
    @images = @listing.images.build
  end

  # GET /listings/1/edit
  def edit
  end

  # POST /listings
  # POST /listings.json
  def create
    @listing = Listing.new(listing_params)
    respond_to do |format|
      if @listing.save
          params[:images]['name'].each do |a|
          @image_params = @listing.images.create!(:name => a)
          format.html { redirect_to @listing, notice: 'New listing had been successfully created.' }
        end
      else
        format.html { render action: 'new' }
      end
    end
  end

  # PATCH/PUT /listings/1
  # PATCH/PUT /listings/1.json
  def update
    respond_to do |format|
      if @listing.update(listing_params)
        format.html { redirect_to @listing, notice: 'Listing was successfully updated.' }
        format.json { render :show, status: :ok, location: @listing }
      else
        format.html { render :edit }
        format.json { render json: @listing.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /listings/1
  # DELETE /listings/1.json
  def destroy
    @listing.destroy
    respond_to do |format|
      format.html { redirect_to listings_url, notice: 'Listing was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_listing
      @listing = Listing.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def listing_params
      params.require(:listing).permit(:name, :location, :address, :status, :description, :price, :latitude,
                                      :longitude, :amenities_id, :user_id, images_attributes: [:id, :listing_id, :name])
    end

end
