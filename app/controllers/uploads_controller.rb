class UploadsController < ApplicationController

  # GET /uploads
  # GET /uploads.json
  def index
    @uploads = Upload.all
  end

  # GET /uploads/1
  # GET /uploads/1.json
  def show
    @uploads =  Upload.where(:format_id => params[:format_id])
    @format_id = params[:format_id].to_i
  end

  # GET /uploads/new
  def new

    @uploads = Upload.where(:format_id => params[:format_id])
    @upload = Upload.new

    @format_id = params[:format_id].to_i
  end

  # GET /uploads/1/edit
  def edit
  end

  # POST /uploads
  # POST /uploads.json
  def create

    @format_id = params[:format_id].to_i

   #if(!Upload.where(:format_id => params[:format_id]).nil?)
   #   Upload.destroy
   # end

    full_params ||= upload_params
    full_params[:format_id] = format_params

    @upload = Upload.new(full_params)
    @upload.save

    if @upload.save(full_params)
      flash[:success] = "Saaaaaaaaaaaaaaaaved"
      redirect_to request.referrer
    else
      render 'edit'
    end
  end

  # PATCH/PUT /uploads/1
  # PATCH/PUT /uploads/1.json
  def update

    @upload = Upload.find(params[:id])

    full_params ||= upload_params
    full_params[:format_id] = format_params

    if @upload.update(upload_params)
      flash[:success] = "Updated successfully"
       redirect_back(fallback_location: root_path)
    else
      render 'edit'
    end


    #respond_to do |format|
     # if @upload.update(full_params)
      #  format.html { redirect_to @upload, notice: 'Upload was successfully updated.' }
       # format.json { render :show, status: :ok, location: @upload }
     # else
      #  format.html { render :edit }
       # format.json { render json: @upload.errors, status: :unprocessable_entity }
      #end
   # end
  end

  # DELETE /uploads/1
  # DELETE /uploads/1.json
  def destroy

    @upload = Upload.find(params[:id])
    @upload.destroy
    respond_to do |format|
      format.html { redirect_to uploads_url, notice: 'Upload was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  #used to remove more than one upload per format
    def remove_multiple_instances

    end

    # Use callbacks to share common setup or constraints between actions.
    def set_upload
      @upload = Upload.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def upload_params
      params.require(:upload).permit(:attachment)
    end
  def format_params
    params.require(:format_id)
  end

end
