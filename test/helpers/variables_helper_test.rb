require 'test_helper'

class VariablesHelperTest < ActiveSupport::TestCase
  include VariablesHelper

  test "empty variable should return true" do
    assert variable_is_empty(variables(:empty))
  end

  test "variable with at least one value should return false" do
    assert_not variable_is_empty(variables(:non_empty))
  end
end