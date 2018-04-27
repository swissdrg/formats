class UploadsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]

  # GET /uploads
  # GET /uploads.json
  def index
    @uploads = Upload.where.not(:attachment => nil)
  end

  # GET /uploads/1
  # GET /uploads/1.json
  def show
    @upload = Upload.find(params[:id])
    @upload_path = @upload.attachment.file.file
    if File.readable?(@upload_path)
      @content = File.read(@upload_path)
    else
      render plain: "Upload can not be shown"
    end
  end

  # GET /uploads/new
  def new
    @uploads = Upload.where(:format_id => format_params[:format_id])
    @upload = upload_params

    @format_id = params[:format_id].to_i
  end

  # GET /uploads/1/edit
  def edit
    @upload = Upload.find(params[:id])
    @changes = ""
    # jsonFiles = Dir.glob "public/uploads/upload/attachment/#{params[:id]}/*.json"
    # json = jsonFiles[0]
    getJson()
    # setJson()
  end

  # POST /uploads
  # POST /uploads.json
  def create
    full_params ||= upload_params
    full_params[:format_id] = format_params

    @upload = Upload.new(full_params)
    @upload.save

    respond_to do |format|
    if @upload.update(full_params)
     format.html { redirect_to @upload, notice: 'Upload was successfully updated.' }
     format.json { render :show, status: :ok, location: @upload }
    else
     format.html { render :edit }
     format.json { render json: @upload.errors, status: :unprocessable_entity }
    end
    end
  end

  # PATCH/PUT /uploads/1
  # PATCH/PUT /uploads/1.json
  def update

    @upload = Upload.find(params[:id])

    full_params ||= upload_params
    full_params[:format_id] = format_params

    respond_to do |format|
      if @upload.update(full_params)
        format.html { redirect_to @upload, notice: 'Upload was successfully updated.' }
        format.json { render :show, status: :ok, location: @upload }
      else
        format.html { render :edit }
        format.json { render json: @upload.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /uploads/1
  # DELETE /uploads/1.json
  def destroy
    @upload = Upload.find(params[:id])
    @upload.destroy
    respond_to do |format|
      format.html { redirect_back(fallback_location: root_path) }
      format.json { head :no_content }
    end
  end

  def getJson
    render plain: File.readable?(@format.attachment.file.path)
    jsonFiles = Dir.glob "public/uploads/upload/attachment/#{params[:id]}/*.json"
    # @json = File.read("public/uploads/upload/attachment/#{format_id}/#{jsonFiles[0]}")
    # @json = File.read("#{jsonFiles[0]}")
  end

  def setJson
    File.open("public/uploads/upload/attachment/#{params[:id]}/.json",'w') do |f|
      f.write(@changes.to_json)
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
