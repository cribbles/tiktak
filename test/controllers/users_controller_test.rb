require 'test_helper'

class UsersControllerTest < ActionController::TestCase

  def setup
    @user       = users(:fred)
    @other_user = users(:wilma)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should redirect profile when not logged in" do
    get :show
    assert_not flash.empty?
    assert_redirected_to login_url
  end
end
