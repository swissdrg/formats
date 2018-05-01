# Generate sample data for Format specifications
module SampleHelper
  require 'faker'
  MIN_LINES = 3
  MAX_LINES = 10

  # Generates multiple sample lines for a Format specification
  def generate_sample(format)
    format = JSON.parse(read_attachment(format), symbolize_keys: true)
    generate_lines(read_types_from(format))
  end

  private

  # Reads all types from a format specification in the correct order
  def read_types_from(json)
    sorted = json['vars'].sort_by { |_, v| v['position'] }

    types = []
    sorted.each do |variable|
      types << variable[1]['type']
    end
    types
  end

  # Generates multiple lines of values joined by newlines
  def generate_lines(types)
    output = ''
    (0...rand(MIN_LINES...MAX_LINES)).each do
      output << "\n" unless output == ''
      output << generate_line(types)
    end
    output
  end

  # Generates values for an entire line and joins it with a separating character
  def generate_line(types)
    output = ''
    types.each do |type|
      output << '|' unless output == ''
      output << generate_value(type).to_s
    end
    output
  end

  # Creates a random value for a certain variable type
  def generate_value(type)
    case
    when type == 'string'
      Faker::Bitcoin.address
    when type == 'int'
      Faker::Number.between(0, 10_000)
    when type == 'float'
      Faker::Number.decimal(3, 3).to_f
    when type == 'boolean'
      Faker::Boolean.boolean
    else ''
    end
  end
end