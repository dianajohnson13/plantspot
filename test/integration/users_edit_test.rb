require 'test_helper'

class UsersEditTest < ActionDispatch::IntegrationTest

  def setup 
    @user = users(:testuser1)
  end

  test "sucessful account edit" do
    get edit_user_path(@user)
    assert_template 'users/edit'
    username  = "editTestUser"
    email = "edit@example.com"
    patch user_path(@user), params: { user: { username:  username,
                                              email: email,
                                              password: "",
                                              password_confirmation: "" } }
    assert_not flash.empty?
    assert_redirected_to @user
    @user.reload
    assert_equal username,  @user.username
    assert_equal email, @user.email
  end

  test "unsuccessful account edit" do
    get edit_user_path(@user)

    assert_template 'users/edit'

    patch user_path(@user), params: { user: {
                                      name: "",
                                      email: "test@invalid",
                                      password: "fail",
                                      password_confirmation: "morefail"
                                      }}

    assert_template 'users/edit'
  end

end
