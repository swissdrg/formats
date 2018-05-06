# Generate sample data for Format specifications
module SampleHelper
  require 'faker'
  MIN_LINES = 3
  MAX_LINES = 10

  # Generates multiple sample lines for a Format specification
  def generate_sample_for(format)
    format = JSON.parse(read_attachment(format), symbolize_keys: true)
    generate_lines(read_types_from(format))
  end

  private

  # Reads all types from a format specification in the correct order
  def read_types_from(json)
    types = if json['multiline'].present? && json['multiline']
              multiline_read_types_from(json)
            else
              vars = json['vars'].map { |k, v| v }
              read_types_for_line(vars)
            end
    types
  end

  def read_types_for_line(arr, start_position = 0)
    types = []
    last_position = start_position

    # Sort the types by position within the line
    sorted = arr.sort_by { |v| v['position'] }
    sorted.each do |var|
      add_empty_types_if_needed(types, last_position, var['position'])
      types << var['type']
      last_position = var['position']
    end
    types
  end

  # Takes a multiline format and returns the types as
  # {"line_1_name": [line_1_type_1, line_1_type_2, ...], "line_2_name": ...}
  def multiline_read_types_from(json)
    vars_by_line = map_vars_to_lines(json['vars'])
    type_by_line = {}

    vars_by_line.map { |line_name, variables|
      start_position = 1 # Because position 0 is reserved for line name
      type_by_line[line_name] = read_types_for_line(variables, start_position)
    }
    type_by_line
  end

  # Maps a hash of variables from
  # { "var1": {position: 1, line:"MD"}, "var2": ...}
  # to
  # { "MD": {{position: 1, line:"MD"}, {position: 2, ...}, ...}
  def map_vars_to_lines(hash)
    lines = {}
    hash.map { |k, var|
      # If necessary, add an empty array to the hash, where the key is the 'line' property of the variable
      lines[var['line']] ||= []
      # Push the variable to hash entry where the key matches the 'line property'
      lines[var['line']] << var
    }
    lines
  end


  def add_empty_types_if_needed(arr, last_position, current_position)
    for _ in (last_position + 1)...current_position do
      arr << 'empty'
    end
    arr
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
      output << generate_value(type).to_s
      output << '|'
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
    when type == 'empty'
      ''
    else ''
    end
  end
end