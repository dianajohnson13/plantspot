require 'test_helper'

class UsersSignupTest < ActionDispatch::IntegrationTest
  test "invalid signup" do
    get signup_path
    # checks for diff between User.count before and after submitting invalid signup
    assert_no_difference 'User.count' do
      post users_path, params: { user: {
          username: "", email: "user@invalid",
          password: "", password_conformation: "blah"
        }
      }
    end
    # checks if invalid signup triggers re-rendering of the 'users/new' page
    assert_template 'users/new'
  end

  test "valid signup" do
    get signup_path

    assert_difference 'User.count' do
      post users_path, params: { user: {
          username: "SomeUser", email: "user@example.com",
          password: "password1", password_conformation: "password1"
        }
      }
    end

    follow_redirect!
    assert_template 'users/show'
  end

end
