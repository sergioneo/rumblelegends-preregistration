require 'test_helper'

class MemberControllerTest < ActionDispatch::IntegrationTest
  test "should get register" do
    get member_register_url
    assert_response :success
  end

end
