require "test_helper"

class ApiControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get api_index_url
    assert_response :success
  end

  test "should get show" do
    get api_show_url
    assert_response :success
  end

  test "should get edit" do
    get api_edit_url
    assert_response :success
  end

  test "should get upgrade" do
    get api_upgrade_url
    assert_response :success
  end

  test "should get delete" do
    get api_delete_url
    assert_response :success
  end
end
