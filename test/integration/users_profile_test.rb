require 'test_helper'

class UsersProfileTest < ActionDispatch::IntegrationTest

  def setup
    @user = users(:fred)
  end

  test "access profile with friendly forwarding" do
    get profile_path
    log_in_as(@user)
    assert_redirected_to profile_path
  end
end
