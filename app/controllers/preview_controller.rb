# Generates a preview of a Format with some input data, using the CSV++ Library
class PreviewController < ApplicationController
  before_action :authenticate_user!, except: [:index]
  include PreviewHelper

  def index
    # Select only formats that have uploads
    @formats = Format.all

    unless preview_parameters[:format_id].present? && preview_parameters[:data_sample].present?
      @output = 'No preview available'
      return
    end

    format = Format.find(preview_parameters[:format_id])
    preview = generate_preview(format)
    render json: { preview: preview } if request.xhr?
  end

  private

  def preview_parameters
    params.permit(:data_sample, :format_id)
  end

  def generate_preview(format)
    data_sample = preview_parameters[:data_sample]
    format_file = File.read(format.attachment.file.path)

    # parse_str method returns an array of hashes
    output_hashes = CSVPP.parse_str(input: data_sample, format: format_file, col_sep: '|')
    build_table(output_hashes).to_s
  end

  # Use xml builder to convert an array of hashes into an html table
  def build_table(output_hashes)
    require 'builder'
    @xm = Builder::XmlMarkup.new(indent: 2)
    @xm.table do
      @xm.tr { output_hashes[0].keys.each { |key| @xm.th(key) } }
      output_hashes.each { |row| @xm.tr { row.values.each { |value| @xm.td(value) } } }
    end
  end
end
