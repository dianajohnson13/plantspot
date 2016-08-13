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
    assert_select "a[href=?]", user_path(@user), count:0
  end

  test "valid login" do
    get login_path
    post login_path, params: {session: 
                                { email: @user.email,
                                  password: 'password' }}
    assert_redirected_to root_url
    follow_redirect!

    assert_select "a[href=?]", login_path, count:0
    assert_select "a[href=?]", logout_path
    assert_select "a[href=?]", user_path(@user)
  end

  test "logout following a valid login" do
    # valid Login
    get login_path
    post login_path, params: {session: 
                                { email: @user.email,
                                  password: 'password' }}
    assert_redirected_to root_url
    follow_redirect!
    
    assert_select "a[href=?]", login_path, count:0
    assert_select "a[href=?]", logout_path
    assert_select "a[href=?]", user_path(@user)

    # Logout
    delete logout_path
    assert_not is_test_user_logged_in?
    
    assert_redirected_to root_url
    # Simulate user clicking logout on a second window (when multiple are open and already logged out on another)
    delete logout_path
    follow_redirect!

    assert_select "a[href=?]", login_path, count:2
    assert_select "a[href=?]", logout_path, count:0
    assert_select "a[href=?]", user_path(@user), count:0
  end

  test "remember login" do
    login_as(@user, remember_me: '1')
    assert_not_nil cookies['remember_token']
  end

  test 'DO NOT remember login' do
    login_as(@user, remember_me: '0')
    assert_nil cookies['remember_token']
  end
end
