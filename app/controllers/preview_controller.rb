class PreviewController < ApplicationController

  def index
    # Select only formats that have uploads
    @formats = Format.all

    if preview_parameters[:format_id].present? && preview_parameters[:data_sample].present?
      format = Format.find(preview_parameters[:format_id])
      dataSample = preview_parameters[:data_sample]

      formatFilePath = format.attachment.file.path
      formatFile = File.read(formatFilePath)

      # parse_str methode returns an array of hashes
      @output = CSVPP.parse_str(:input => dataSample, :format => formatFile, :col_sep => '|')

      # use xml builder to convert the array of hashes into an html table
      require 'builder'
      @xm = Builder::XmlMarkup.new(:indent => 2)
      @xm.table {
        @xm.tr { @output[0].keys.each { |key| @xm.th(key)}}
        @output.each { |row| @xm.tr { row.values.each { |value| @xm.td(value)}}}
      }

      if request.xhr?
        render :json => {
            :preview => "#{@xm}"
        }
      end
    else
      @output = "No preview available."
    end
  end

  private
  def preview_parameters
    params.permit(:data_sample, :format_id)
  end
end

=begin
Sample data:

34|foobar|1.1|false
99|hi  there|2.2|100
-999|Missing|NA|korrektos

=end
