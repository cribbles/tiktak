require 'test_helper'

class ApplicationHelperTest < ActionView::TestCase
  test "full title helper" do
    assert_equal full_title,        Settings.site_name
    assert_equal full_title('FAQ'), Settings.site_name + " - FAQ"
  end
end
