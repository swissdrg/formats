# Reads all types from a format specification in the correct order
module FormatTypeHelper

  # Reads all types from a format specification in the correct order
  def read_types_from(format)
    types = if format['multiline'].present? && format['multiline']
              multiline_read_types_from(format)
            else
              vars = format['vars'].map {|_, v| v}
              read_types_for_line(vars)
            end
  end

  private

  def read_types_for_line(arr, start_position = 0)
    types = []
    last_position = start_position

    # Sort the types by position within the line
    sorted = arr.sort_by {|v| v['position']}
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

    vars_by_line.map {|line_name, variables|
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
    hash.map {|_, var|
      # If necessary, add an empty array to the hash, where the key is the 'line' property of the variable
      lines[var['line']] ||= []
      # Push the variable to hash entry where the key matches the 'line property'
      lines[var['line']] << var
    }
    lines
  end

  def add_empty_types_if_needed(arr, last_position, current_position)
    ((last_position + 1)...current_position).each do
      arr << 'empty'
    end
  end
end
