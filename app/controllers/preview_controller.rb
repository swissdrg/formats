# Generates a preview of a Format with some input data, using the CSV++ Library
class PreviewController < ApplicationController
  before_action :authenticate_user!, except: [:index]

  def index
    # Select only formats that have uploads
    puts request.xhr?
    @formats = Format.all

    unless preview_parameters[:format_id].present? && preview_parameters[:data_sample].present?
      @output = 'No preview available'
      return
    end

    format = Format.find(preview_parameters[:format_id])
    preview = helpers.generate_preview(format, preview_parameters[:data_sample])
    render json: { preview: preview } if request.xml_http_request?
  end

  def sample
    format = Format.find(generate_sample_parameters[:format_id])
    sample = helpers.generate_sample(format)
    render json: { sample: sample} if request.xml_http_request?
  end

  private

  def preview_parameters
    params.permit(:data_sample, :format_id)
  end

  def generate_sample_parameters
    params.permit(:format_id)
  end


end
