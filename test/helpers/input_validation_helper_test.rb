require 'test_helper'

class InputValidationHelperTest < ActionDispatch::IntegrationTest
  include InputValidationHelper

  test 'input should be valid' do
    # given
    raw = file_fixture('/sample_formats/simple.json').read
    format = JSON.parse(raw, symbolize_keys: true)
    input = file_fixture('/sample_inputs/simple.txt').read

    # when
    valid = validate(format, input)

    # then
    assert valid
  end

  test 'input with empty should be valid' do
    # given
    raw = file_fixture('/sample_formats/simple_with_empty.json').read
    format = JSON.parse(raw, symbolize_keys: true)
    input = file_fixture('/sample_inputs/simple_with_empty.txt').read

    # when
    valid = validate(format, input)

    # then
    assert valid
  end

  test 'mismatched input should be invalid' do
    # given
    raw = file_fixture('/sample_formats/simple_with_empty.json').read
    format = JSON.parse(raw, symbolize_keys: true)
    input = file_fixture('/sample_inputs/simple.txt').read

    # when
    actual = validate(format, input)

    # then
    expected = {valid: false, line_number: 0}
    assert_equal(expected, actual)
  end

  test 'multiline input should be valid' do
    # given
    raw = file_fixture('/sample_formats/multiline.json').read
    format = JSON.parse(raw, symbolize_keys: true)
    input = file_fixture('/sample_inputs/multiline.txt').read

    # when
    valid = validate(format, input)

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
    expected = /^.*(\|)+.*(\|)+.*(\|)+.*$/
    assert(expected.eql?(regex), 'Expected regex to be functionally equivalent')
  end

  test 'build regex for types with empty columns' do
    # given
    types = %w[int string empty float empty boolean]

    # when
    regex = build_regex_with(types)

    #then
    expected = /^.*(\|)+.*(\|)+(\|)+.*(\|)+(\|)+.*$/
    assert(expected.eql?(regex), 'Expected regex to be functionally equivalent')
  end

  test 'build regex for multiline types' do
    # given
    types = { 'MB' => %w[string string], 'MN' => %w[empty string], 'MD' => %w[empty empty string] }

    # when
    regex = multiline_build_regex_with(types)

    # then
    expected = /(MB(\|)+.*(\|)+.*(\|)*)\|\|(MN(\|)+(\|)+.*(\|)*)\|\|(MD(\|)+(\|)+(\|)+.*(\|)*)/
    assert(expected.eql?(regex), 'Expected regex to be functionally equivalent')
  end
end