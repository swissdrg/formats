module PreviewHelper
  include AttachmentHelper

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
    format_file = read_attachment(format)

    # parse_str method returns an array of hashes
    output_hashes = CSVPP.parse_str(input: data_sample, format: format_file, col_sep: '|')
    build_table(output_hashes).to_s
  end

  def generate_sample(format)
    format = JSON.parse(read_attachment(format), symbolize_keys: true)
    generate_sample_lines(read_types_from(format))
  end

  def read_types_from(json)
    sorted = json['vars'].sort_by { |_, v| v['position'] }

    types = []
    sorted.each do |variable|
      types << variable[1]['type']
    end
    types
  end

  def generate_sample_lines(types)
    output = ''
    (0...rand(1...10)).each do
      output << "\n" unless output == ''
      output << generate_sample_line(types)
    end
    output
  end

  def generate_sample_line(types)
    output = ''
    types.each do |type|
      output << '|' unless output == ''
      output << generate_value_for_type(type).to_s
    end
    output
  end

  def generate_value_for_type(type)
    require 'faker'

    case
    when type == 'string'
      Faker::Bitcoin.address
    when type == 'int'
      Faker::Number.between(0, 10_000)
    when type == 'float'
      Faker::Number.decimal(3, 3).to_f
    when type == 'boolean'
      Faker::Boolean.boolean
    end
  end

end
