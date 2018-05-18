# Checks whether a given input is able to match a specification
module InputValidationHelper
  include FormatTypeHelper
  include AttachmentHelper

  # Validates the input against a format specification and returns the first faulty line number if present
  def validate(format, input)
    format = JSON.parse(read_attachment(format)) if format.class == Format
    regex = build_regex_for(format)
    valid = true
    input.split(/\r?\n/).each_with_index { |str, index|
      line_match = str.match(regex)
      valid &= line_match
      return { valid: valid, line_number: index } unless valid
    }
    { valid: valid }
  end

  private

  # Builds a regular expression for an entire format specification
  def build_regex_for(format)
    types = read_types_from(format)
    regex = if format['multiline'].present? && format['multiline']
              multiline_build_regex_with(types)
            else
              build_regex_with(types)
            end
  end

  # Builds a regular expression for a format that is not multiline
  # The expression will match entire lines.
  def build_regex_with(types)
    string = raw_string_for(types)
    /^#{string}$/
  end

  # Builds a regular expression for a format that is multiline.
  # The expression will check for the line name in the first parameter.
  # e.g. "MD|hello|123" where MD is the name of the line.
  def multiline_build_regex_with(types)
    string = ''
    types.each_key { |k|
      string << ('(' + k + '(\|)+' + raw_string_for(types[k]) + '(\|)*)||')
    }
    /#{string.chop.chop}/
  end

  # Builds a string that is the 'inner part' of a regular expression,
  # i.e. the expression matching all the types separated
  # by one or multiple separation characters. (e.g. '|')
  def raw_string_for(types)
    string = ''
    types.each do |type|
      string << regex_for(type) << '(\|)+'
    end
    string[0...string.length - 5]
  end

  # Returns an appropriate expression for the provided type
  # Could be improved if true and missing values could be included
  # in the type description. This would enable more precise matching.
  def regex_for(type)
    if %w[string int float boolean].include? type
      '.*'
    else
      ''
    end
  end

end