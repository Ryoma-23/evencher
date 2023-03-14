require "test_helper"

class Admin::EventCommentsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get admin_event_comments_index_url
    assert_response :success
  end
end
