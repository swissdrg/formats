class PreviewController < ApplicationController
  def index
    # TODO: Filter formats to only display the ones that have an upload
    # Maybe something like
    # @formats = Format.joins(:upload).where.not(upload: nil)

    @formats = Format.all

    if preview_parameters[:format_id].present? && preview_parameters[:data_sample].present?
      format = Format.find(preview_parameters[:format_id])
      dataSample = preview_parameters[:data_sample]

      formatFilePath = format.upload.attachment.file.path

      formatFile = File.read(formatFilePath)

      @output = CSVPP.parse_str(:input => dataSample, :format => formatFile, :col_sep => '|')
    else
      @output = "No preview available."
    end
  end

  private
  def preview_parameters
    params.permit(:data_sample, :format_id)
  end
end
