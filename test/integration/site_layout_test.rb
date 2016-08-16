require 'test_helper'

class SiteLayoutTest < ActionDispatch::IntegrationTest
  test "layout links" do
    get root_path
    assert_template 'static_pages/home'
    assert_select "a[href=?]", root_path, count: 2
    assert_select "a[href=?]", help_path
    assert_select "a[href=?]", about_path
    assert_select "a[href=?]", login_path, count: 2
    assert_select "a[href=?]", signup_path
    assert_select "a[href=?]", users_path
  end

  test "layout link full_title helper" do
    get about_path
    assert_select "title", full_title("About")
    get signup_path
    assert_select "title", full_title("Signup")
  end

end
