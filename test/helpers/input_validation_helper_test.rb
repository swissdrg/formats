require 'test_helper'

class InputValidationHelperTest < ActionDispatch::IntegrationTest
  include InputValidationHelper

  test 'input should be valid' do
    # given
    raw = file_fixture('/sample_formats/simple.json').read
    format = JSON.parse(raw, symbolize_keys: true)
    input = file_fixture('/sample_inputs/simple.txt').read

    # when
    valid = validate(input, format)

    # then
    assert valid
  end

  test 'input should be invalid' do
    # given
    raw = file_fixture('/sample_formats/simple_with_empty.json').read
    format = JSON.parse(raw, symbolize_keys: true)
    input = file_fixture('/sample_inputs/simple.txt').read

    # when
    valid = validate(input, format)

    # then
    assert_not valid
  end

  test 'multiline input should be valid' do
    # given
    raw = file_fixture('/sample_formats/multiline.json').read
    format = JSON.parse(raw, symbolize_keys: true)
    input = file_fixture('/sample_inputs/multiline.txt').read

    # when
    valid = validate(input, format)

    # then
    assert valid
  end

  test 'build regex for simple format' do
    # given
    raw = file_fixture('/sample_formats/simple.json').read
    format = JSON.parse(raw, symbolize_keys: true)

    # when
    regex = build_regex_for(format)

    # then
    expected = /^[[:digit:]]*(\|)+[[:alnum:]]*(\|)+[[:digit:]]*.[[:digit:]]*(\|)+((true)||(false))$/
    assert(expected.eql?(regex), 'Expected regex to be functionally equivalent')
  end

  test 'build regex for types with empty columns' do
    # given
    types = %w[int string empty float empty boolean]

    # when
    regex = build_regex_with(types)

    #then
    expected = /^[[:digit:]]*(\|)+[[:alnum:]]*(\|)+(\|)+[[:digit:]]*.[[:digit:]]*(\|)+(\|)+((true)||(false))$/
    assert(expected.eql?(regex), 'Expected regex to be functionally equivalent')
  end

  test 'build regex for multiline types' do
    # given
    types = { 'MB' => %w[string string], 'MN' => %w[empty string], 'MD' => %w[empty empty string] }

    # when
    regex = multiline_build_regex_with(types)

    # then
    expected = /(MB(\|)+[[:alnum:]]*(\|)+[[:alnum:]]*(\|)*)||(MN(\|)+(\|)+[[:alnum:]]*(\|)*)||(MD(\|)+(\|)+(\|)+[[:alnum:]]*(\|)*)/
    assert(expected.eql?(regex), 'Expected regex to be functionally equivalent')
  end
end