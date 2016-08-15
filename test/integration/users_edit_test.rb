require 'test_helper'

class UsersEditTest < ActionDispatch::IntegrationTest

  def setup 
    @user = users(:testuser1)
    @other_user = users(:testuser2)
  end

  test "sucessful account edit" do
    login_as(@user)
    get edit_user_path(@user)
    assert_template 'users/edit'
    username  = @user.username
    email = @user.email
    patch user_path(@user), params: { user: { username:  username,
                                              email: email,
                                              password: "",
                                              password_confirmation: "" } }
    assert_redirected_to @user
    @user.reload
    assert_equal username,  @user.username
    assert_equal email, @user.email
  end

  test "unsuccessful account edit" do
    login_as(@user)
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

  test "should redirect attempted edit when logged in as wrong user" do
    login_as(@other_user)

    get edit_user_path(@user)
    assert_redirected_to root_url
  end

  test "should redirect attempted update when logged in as wrong user" do
    login_as(@other_user)
    patch user_path(@user), params: {user: { username: @user.username,
                                             email: @user.email
                                            }}
    assert_redirected_to root_url
  end

end
