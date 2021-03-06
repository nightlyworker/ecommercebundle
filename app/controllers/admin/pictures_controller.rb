class Admin::PicturesController < PicturesController
  before_action :set_picture, only: [:show, :edit, :update, :destroy]
  before_filter :load_picturable
  before_action :authenticate_user!

  # GET /pictures
  # GET /pictures.json
  def index
    @pictures = @picturable.pictures
  end

  # GET /pictures/1
  # GET /pictures/1.json
  def show
  end

  # GET /pictures/new
  def new
    @picture = @picturable.pictures.new
  end

  # GET /pictures/1/edit
  def edit
  end

  # POST /pictures
  # POST /pictures.json
  def create
    @picture = @picturable.pictures.new(picture_params)

    respond_to do |format|
      if @picture.save
        format.html { redirect_to admin_picture_path(@picture), notice: 'picture was successfully created.' }
        format.json { render :show, status: :created, location: @picture }
      else
        format.html { render :new }
        format.json { render json: @picture.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /pictures/1
  # PATCH/PUT /pictures/1.json
  def update
    respond_to do |format|
      if @picture.update(picture_params)
        format.html { redirect_to admin_picture_path(@picture), notice: 'picture was successfully updated.' }
        format.json { render :show, status: :ok, location: @picture }
      else
        format.html { render :edit }
        format.json { render json: @picture.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /pictures/1
  # DELETE /pictures/1.json
  def destroy
    @picture.destroy
    respond_to do |format|
      format.html { redirect_to admin_pictures_path, notice: 'picture was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def load_picturable
    resource, id = request.path.split('/')[1, 2]
    @picturable = resource.singularize.classify.constantize.find(id)
  end

  def set_picture
    @picture = Picture.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def picture_params
    params.require(:picture).permit(:profile_picture)
  end
end
