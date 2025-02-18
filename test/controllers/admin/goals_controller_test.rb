require "test_helper"

class Admin::GoalsControllerTest < ActionDispatch::IntegrationTest
  test "should get edit" do
    get admin_goals_edit_url
    assert_response :success
  end

  test "should get index" do
    get admin_goals_index_url
    assert_response :success
  end

  test "should get show" do
    get admin_goals_show_url
    assert_response :success
  end
end
