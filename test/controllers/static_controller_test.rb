require 'test_helper'

class StaticControllerTest < ActionController::TestCase

  test "should get terms" do
    get :terms
    assert_response :success
  end

  test "should get faq" do
    get :faq
    assert_response :success
  end

  test "should get stats" do
    get :stats
    assert_response :success
  end
end
