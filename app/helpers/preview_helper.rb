module PreviewHelper

  # Use xml builder to convert an array of hashes into an html table
  def build_table(output_hashes)
    require 'builder'
    xm = Builder::XmlMarkup.new(indent: 2)
    xm.table do
      xm.tr { output_hashes[0].keys.each { |key| xm.th(key) } }
      output_hashes.each { |row| xm.tr { row.values.each { |value| xm.td(value) } } }
    end
  end

  def generate_preview(format, data_sample)
    format_file = File.read(format.attachment.file.path)

    # parse_str method returns an array of hashes
    output_hashes = CSVPP.parse_str(input: data_sample, format: format_file, col_sep: '|')
    build_table(output_hashes).to_s
  end

  def generate_sample(format)
    return if format.file.present?
    "sample"
  end
end
