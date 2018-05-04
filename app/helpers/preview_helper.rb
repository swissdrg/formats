# Creates a preview for format with sample data
module PreviewHelper
  include AttachmentHelper
  def generate_preview(format, data_sample)
    format_file = read_attachment(format)

    # parse_str method returns an array of hashes
    output_hashes = CSVPP.parse_str(input: data_sample, format: format_file, col_sep: '|')
    puts output_hashes.inspect
    # puts output_hashes.inspect
    output_hashes = output_hashes.map { |arr|
      arr = {"Line" => arr.delete('line_number')}.merge(arr)
    }


    build_table(output_hashes).to_s
  end

end