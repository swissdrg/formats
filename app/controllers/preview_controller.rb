# Generates a preview of a Format with some input data, using the CSV++ Library
require 'tempfile'
class PreviewController < ApplicationController
  before_action :authenticate_user!, except: %i[index sample download]
  before_action :check_for_formats
  def index
    # Select only formats that have uploads
    @format = Format.find(preview_parameters[:format_id]) if preview_parameters[:format_id].present?

    unless preview_parameters[:format_id].present? && preview_parameters[:data_sample].present?
      @output = 'No preview available'
      return
    end

    show_preview(preview_parameters[:format_id], preview_parameters[:data_sample])
  end

  def sample
    format = Format.find(generate_sample_parameters[:format_id])
    sample = helpers.generate_sample_for(format)
    render json: { sample: sample } if request.xml_http_request?
  end

  def download
    csv = ::Tempfile.new("/data.csv", "#{Rails.root.to_s}/tmp/")
    csv.write params[:data].gsub(/\|/, ',')
    csv.flush
    send_file csv, :type=>"text/csv", :filename => "data.csv"

  end

  private

  def show_preview(format_id, data_sample)
    return unless request.xml_http_request?

    format = Format.find(format_id)
    validation = helpers.validate(format, data_sample)

    puts validation

    if validation[:valid]
      preview = helpers.generate_preview(format, data_sample)
      render json: {
          preview: preview,
          data: data_sample
      }
    else
      render json: { faultyLineNumber: validation[:line_number] }
    end
  end

  def check_for_formats
    return unless Format.all.empty?
    redirect_back fallback_location: root_path,
                  flash: { alert: 'No Preview available because there are no formats yet' }
  end

  def preview_parameters
    params.permit(:data_sample, :format_id)
  end

  def generate_sample_parameters
    params.permit(:format_id)
  end
end
