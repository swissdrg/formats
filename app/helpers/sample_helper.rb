# Generate sample data for Format specifications
module SampleHelper
  require 'faker'
  include FormatTypeHelper

  MIN_LINES = 3
  MAX_LINES = 10

  # Generates multiple sample lines for a Format specification
  def generate_sample_for(format)
    format = JSON.parse(read_attachment(format), symbolize_keys: true)
    generate_lines(read_types_from(format))
  end

  private

  # Generates multiple lines of values joined by newlines
  def generate_lines(types)
    output = ''
    (0...rand(MIN_LINES...MAX_LINES)).each do
      output << generate_block(types) << "\n"
    end
    output.chop
  end

  # Generates values for an entire line and joins it with a separating character
  # If the input are multiline types (i.e. a hash with keys that are the line names and values that are types),
  # this generates a block of all those lines.
  def generate_block(types)
    block = ''
    if types.class == Hash
      types.each_key { |k|
        block << (k + '|' + generate_line(types[k]) + "\n")
      }
    else
      block = generate_line(types)
    end
    block
  end

  def generate_line(types)
    output = ''
    types.each do |type|
      output << generate_value(type).to_s << '|'
    end
    output.chop
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