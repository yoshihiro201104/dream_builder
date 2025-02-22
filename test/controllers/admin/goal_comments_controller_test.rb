require "test_helper"

class Admin::GoalCommentsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get admin_goal_comments_index_url
    assert_response :success
  end
end
