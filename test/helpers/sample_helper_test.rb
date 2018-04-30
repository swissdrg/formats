require 'test_helper'

class SampleHelperTest < ActionDispatch::IntegrationTest
  include SampleHelper

  test 'parsed types should match' do
    #given
    raw = file_fixture('/sample_formats/simple.json').read
    json = JSON.parse(raw, symbolize_keys: true)

    # when
    types = read_types_from(json)

    # then
    expected = %w[int string float boolean]
    assert_equal(expected, types, 'Should match')
  end

  test 'generate string' do
    #given
    type = 'string'

    #when
    generated = generate_value(type)

    #then
    assert generated.is_a?(String)
  end

  test 'generate int' do
    #given
    type = 'int'

    #when
    generated = generate_value(type)

    #then
    assert generated.is_a?(Integer)
  end

  test 'generate float' do
    #given
    type = 'float'

    #when
    generated = generate_value(type)

    #then
    assert generated.is_a?(Float)
  end

  test 'generate boolean' do
    #given
    type = 'boolean'

    #when
    generated = generate_value(type)

    #then
    assert !!generated == generated
  end

  test 'generate sample line' do
    # given
    types = %w[int string float boolean]

    #when
    line = generate_line(types)

    #then
    expected = /^[[:digit:]]*\|[[:alnum:]]*\|[[:digit:]]*.[[:digit:]]*\|((true)||(false))$/
    assert expected.match?(line)
  end

  test 'generate multiple lines' do
    #given
    types = %w[int string float boolean]

    #when
    lines = generate_lines(types)

    #then
    expected = /^([[:digit:]]*\|[[:alnum:]]*\|[[:digit:]]*.[[:digit:]]*\|((true)||(false))\n?)*$/
    assert expected.match?(lines)
  end
end
