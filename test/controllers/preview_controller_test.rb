require 'test_helper'

class PreviewControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get preview_index_url
    assert_response :success
  end

end
