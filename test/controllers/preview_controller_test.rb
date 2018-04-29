require 'test_helper'

class PreviewControllerTest < ActionDispatch::IntegrationTest
  test 'should get index' do
    get preview_index_url
    assert_response :success
  end

  test 'should be able to use CSV++' do
    simple_format = file_fixture '/sample_formats/simple.json'
    puts simple_format
    simple_input = file_fixture '/sample_inputs/simple.txt'

    simple_output = CSVPP.parse(input: simple_input, format: simple_format)

    expected_output = [{ 'line_number' => 1, 'v1' => 34, 'v2' => 'foobar', 'v3' => 1.1, 'v4' => false },
                       { 'line_number' => 2, 'v1' => 99, 'v2' => 'hi  there', 'v3' => 2.2, 'v4' => true },
                       { 'line_number' => 3, 'v1' => nil, 'v2' => 'Missing', 'v3' => nil, 'v4' => true }]

    assert_equal(expected_output, simple_output, 'Should be equal')
  end
end
