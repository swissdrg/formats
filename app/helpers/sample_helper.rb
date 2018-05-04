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
    types = if json['multiline'].present? && json['multiline']
              multiline_read_types_from(json)
            else
              sorted = json['vars'].sort_by { |_, v| v['position'] }
              simple_read_types_from(sorted)
            end
    types
  end

  def simple_read_types_from(json)
    types = []
    json.each do |variable|
      types << variable[1]['type']
    end
    types
  end

  # Takes a multiline format and returns the types as
  # {"line_1_name": [line_1_type_1, line_1_type_2, ...], "line_2_name": ...}
  def multiline_read_types_from(json)
    vars_by_line = {}
    type_by_line = {}

    json['vars'].map { |k, v|
      # If necessary, add an empty array to the hash, where the key is the 'line' property of the variable
      # Push the variable to hash entry where the key matches the 'line property'
      (vars_by_line[v['line']] ||= []) << v
    }
    vars_by_line.map { |line_name, variables|
      # Sort the types by position within the line
      sorted = variables.sort_by { |v| v['position'] }
      type_by_line[line_name] = sorted.map { |v| v['type'] }
    }
    type_by_line
  end

  # Generates multiple lines of values joined by newlines
  def generate_lines(types)
    output = ''
    (0...rand(MIN_LINES...MAX_LINES)).each do
      output << "\n" unless output == ''
      output << generate_block(types)
    end
    output
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