require 'test_helper'

class FormatsControllerTest < ActionDispatch::IntegrationTest
  test 'should get index' do
    get formats_url
    assert_response :success
  end
end
