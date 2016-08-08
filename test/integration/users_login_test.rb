require 'test_helper'

class UsersLoginTest < ActionDispatch::IntegrationTest
  
  def setup
    @user = users(:testuser1)
  end


  test "invalid user login" do
    get login_path
    post login_path, params: {session: 
                                { email: 'notauser@invalid',
                                  password: 'password' }}

    assert_template 'sessions/new'
    assert_select "a[href=?]", login_path
  end

  test "valid login" do
    get login_path
    post login_path, params: {session: 
                                { email: @user.email,
                                  password: 'password' }}
    assert_redirected_to @user
    follow_redirect!
    assert_template 'users/show'
    assert_select "a[href=?]", login_path, count:0
    assert_select "a[href=?]", logout_path
    assert_select "a[href=?]", user_path(@user)
  end

end
