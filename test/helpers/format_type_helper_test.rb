require 'test_helper'

class FormatTypeHelperTest < ActionDispatch::IntegrationTest
  include FormatTypeHelper

  test 'read types from simple format' do
    # given
    raw = file_fixture('/sample_formats/simple.json').read
    json = JSON.parse(raw, symbolize_keys: true)

    # when
    types = read_types_from(json)

    # then
    expected = %w[int string float boolean]
    assert_equal(expected, types, 'Should match')
  end


  test 'read types from format with empty columns' do
    # given
    raw = file_fixture('/sample_formats/simple_with_empty.json').read
    json = JSON.parse(raw, symbolize_keys: true)

    # when
    types = read_types_from(json)

    # then
    expected = %w[int empty float boolean]
    assert_equal(expected, types, 'Should match')
  end

  test 'read types from multiline format' do
    # given
    raw = file_fixture('/sample_formats/multiline.json').read
    json = JSON.parse(raw, symbolize_keys: true)

    # when
    types = read_types_from(json)

    # then
    expected = { 'MB' => %w[string string], 'MN' => %w[empty string], 'MD' => %w[empty empty string] }
    assert_equal(expected, types, 'Should match')
  end
end
