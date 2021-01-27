require "test_helper"

class UserdetailsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get userdetails_index_url
    assert_response :success
  end
end
