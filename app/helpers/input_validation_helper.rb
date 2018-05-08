module InputValidationHelper
  include FormatTypeHelper

  def validate(input, format)
    regex = build_regex_for(format)
    valid = true
    input.split(/\r?\n/).each_with_index { |str, index|
      line_match = str.match(regex)
      puts regex unless line_match
      puts str unless line_match
      puts "Mismatch at index #{index}" unless line_match
      valid &= line_match
    }
    valid
  end

  def build_regex_for(format)
    types = read_types_from(format)
    regex = if format['multiline'].present? && format['multiline']
              multiline_build_regex_with(types)
            else
              build_regex_with(types)
            end
    regex
  end

  def build_regex_with(types)
    string = raw_string_for(types)
    /^#{string}$/
  end

  def multiline_build_regex_with(types)
    string = ''
    types.each_key { |k|
      string << ('(' + k + '(\|)+' + raw_string_for(types[k]) + '(\|)*)||')
    }
    /#{string.chop.chop}/
  end

  def raw_string_for(types)
    string = ''
    types.each do |type|
      string << regex_for(type) << '(\|)+'
    end
    string[0...string.length - 5]
  end

  def regex_for(type)
    case
    when type == 'string'
      '[[:alnum:]]*'
    when type == 'int'
      '[[:digit:]]*'
    when type == 'float'
      '[[:digit:]]*.[[:digit:]]*'
    when type == 'boolean'
      '((true)||(false))'
    else ''
    end
  end

end