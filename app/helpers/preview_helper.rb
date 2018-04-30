module PreviewHelper
  include AttachmentHelper



  def generate_preview(format, data_sample)
    format_file = read_attachment(format)

    # parse_str method returns an array of hashes
    output_hashes = CSVPP.parse_str(input: data_sample, format: format_file, col_sep: '|')
    build_table(output_hashes).to_s
  end

end
