class PreviewController < ApplicationController

  def index
    # Select only formats that have uploads
    @formats = Format.includes(:upload)
                   .references(:upload)
                   .merge(Upload.where.not(:id => nil, :attachment => nil))

    if preview_parameters[:format_id].present? && preview_parameters[:data_sample].present?
      format = Format.find(preview_parameters[:format_id])
      dataSample = preview_parameters[:data_sample]

      formatFilePath = format.upload.attachment.file.path
      formatFile = File.read(formatFilePath)

      @output = CSVPP.parse_str(:input => dataSample, :format => formatFile, :col_sep => '|')

      if request.xhr?
        render :json => {
            :preview => @output
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
