require 'test_helper'

class SampleHelperTest < ActionDispatch::IntegrationTest
  include SampleHelper

  # GENERATE VALUES

  test 'generate string' do
    # given
    type = 'string'

    # when
    generated = generate_value(type)

    # then
    assert generated.is_a?(String)
  end

  test 'generate int' do
    # given
    type = 'int'

    # when
    generated = generate_value(type)

    # then
    assert generated.is_a?(Integer)
  end

  test 'generate float' do
    # given
    type = 'float'

    # when
    generated = generate_value(type)

    # then
    assert generated.is_a?(Float)
  end

  test 'generate boolean' do
    # given
    type = 'boolean'

    # when
    generated = generate_value(type)

    # then
    assert !!generated == generated
  end

  # GENERATE LINES

  test 'generate simple line' do
    # given
    types = %w[int string float boolean]

    # when
    line = generate_block(types)

    # then
    expected = /^[[:digit:]]*\|[[:alnum:]]*\|[[:digit:]]*.[[:digit:]]*\|((true)||(false))$/
    assert expected.match?(line)
  end

  test 'generate line with skipped columns' do
    # given
    types = %w[int string empty float empty boolean]

    # when
    lines = generate_block(types)

    #then
    expected = /^[[:digit:]]*\|[[:alnum:]]*(\|){2}[[:digit:]]*.[[:digit:]]*(\|){2}((true)||(false))$/
    assert_match(expected, lines)
  end

  test 'generate multiple lines of simple format' do
    # given
    types = %w[int string float boolean]

    # when
    lines = generate_lines(types, 10)

    # then
    expected = /^([[:digit:]]*\|[[:alnum:]]*\|[[:alnum:]]*.[[:alnum:]]*\|((true)||(false))\n?)*$/
    assert_match(expected, lines)
  end

  test 'generate lines from multiline format' do
    # given
    types = { 'MB' => %w[string string], 'MN' => %w[empty string], 'MD' => %w[empty empty string] }

    # when
    lines = generate_block(types)

    # then
    expected = /MB(\|[[:alnum:]]+){2}\nMN(\|){2}[[:alnum:]]+\nMD(\|){3}[[:alnum:]]+/
    assert_match(expected, lines)
  end

end
