require 'test_helper'

class MicropostsControllerTest < ActionDispatch::IntegrationTest
  
  def setup
    @micropost = microposts(:trees)
  end

  test "should redirect create to login when user not logged in" do
    assert_no_difference 'Micropost.count' do
      post microposts_path, params: {micropost: {content: "Hello!!"}}
    end
    assert_redirected_to login_path   
  end

  test "should redirect destroy to login when user is not logged in" do
    assert_no_difference 'Micropost.count' do
      post microposts_path, params: {micropost: {content: "Hello!!"}}
    end
    assert_redirected_to login_path
  end

end
