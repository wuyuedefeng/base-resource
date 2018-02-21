require 'test_helper'
class BaseResource::Test < ActiveSupport::TestCase
  test "truth" do
    assert_kind_of Module, BaseResource
  end
end
