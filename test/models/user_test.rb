require 'test_helper'

class UserTest < ActiveSupport::TestCase
  def setup
    @user = User.new(username: "Test User", email: "user@example.com",
                      password: "password1", password_confirmation: "password1")
  end

  test "user should be valid" do
    assert @user.valid?
  end

  test "username should be present" do
    @user.username = "    "
    assert_not @user.valid?
  end

  test "email should be present" do
    @user.email = "    "
    assert_not @user.valid?
  end

  test "username should not be too long" do
    @user.username = "a" * 51
    assert_not @user.valid?
  end

  test "email should not be too long" do
    @user.email = "a" * 244 + "@example.com"
    assert_not @user.valid?
  end

  test "usernames should be unique" do
    dup_user = @user.dup
    dup_user.username = @user.username
    @user.save
    assert_not dup_user.valid?
  end

  test "email addresses should be unique" do
    dup_user = @user.dup
    dup_user.email = @user.email.upcase
    @user.save
    assert_not dup_user.valid?
  end

  test "email addresses should be lower-case" do
    mixed_case_email = "uSerEmail@ExAMpLe.Com"
    @user.email = mixed_case_email
    @user.save
    assert_equal mixed_case_email.downcase, @user.reload.email
  end

  test "password should be present" do 
    @user.password = @user.password_confirmation = " " * 6
    assert_not @user.valid?
  end

  test "password should have a minimum length" do
    @user.password = @user.password_confirmation = "a" * 5
    assert_not @user.valid?
  end

  test "associated microposts should be destroyed when user deletes account" do
    @user.save
    Micropost.create(content: "Hello!", user_id: @user[:id])
    assert_difference 'Micropost.count', -1 do
    @user.destroy
    end
  end

  test "mini bios are not required" do
    assert @user.valid?
  end

  test "mini bios should have a maximum length" do
    @user.mini_bio = "a" * 256
    assert_not @user.valid?
  end

  test "authenticated? should return false for user with nil remember_digest" do
    assert_not @user.authenticated?('')
  end

end
