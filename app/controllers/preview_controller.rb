# Generates a preview of a Format with some input data, using the CSV++ Library
class PreviewController < ApplicationController
  before_action :authenticate_user!, except: [:index, :sample]
  before_action :check_for_formats
  def index
    # Select only formats that have uploads
    @formats = Format.all

    unless preview_parameters[:format_id].present? && preview_parameters[:data_sample].present?
      @output = 'No preview available'
      return
    end

    show_preview(preview_parameters[:format_id], preview_parameters[:data_sample])
  end

  def sample
    format = Format.find(generate_sample_parameters[:format_id])
    sample = helpers.generate_sample(format)
    render json: { sample: sample } if request.xml_http_request?
  end

  private

  def show_preview(format_id, data_sample)
    format = Format.find(format_id)
    preview = helpers.generate_preview(format, data_sample)
    render json: { preview: preview } if request.xml_http_request?
  end

  def check_for_formats
    if Format.all.empty?
      redirect_back fallback_location: root_path,flash: {alert: "No Preview available because there are no formats yet"}
    end

  end

  def preview_parameters
    params.permit(:data_sample, :format_id)
  end

  def generate_sample_parameters
    params.permit(:format_id)
  end
end
