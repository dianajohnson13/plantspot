require 'test_helper'

class UsersSignupTest < ActionDispatch::IntegrationTest
  test "invalid signup" do
    get signup_path

    # checks for diff between User.count before and after submitting invalid signup
    assert_no_difference 'User.count' do
      post users_path, params: { user: {
        name: "", email: "user@invalid",
        password: "", password_conformation: "blah"
        }}
    end

    # checks if invalid signup triggers re-rendering of the 'users/new' page
    assert_template 'users/new'
  end
end
