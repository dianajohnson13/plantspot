require 'test_helper'

class MicropostTest < ActiveSupport::TestCase
  
  def setup
    @user = users(:testuser1)
    @micropost = @user.microposts.build(content: "Meow")
  end

  test "micropost should be valid" do
    assert @micropost.valid?
  end

  test "user_id should be included" do
    !@micropost.nil?
  end

  test "content should be present" do
    @micropost.content = "    "
    assert_not @micropost.valid?
  end

  test "content should not be more than 140 characters" do
    @micropost.content = "a" * 141
    assert_not @micropost.valid?
  end

  test "posts should be ordered with newest first oldest last" do
    assert_equal microposts(:most_recent), Micropost.first
  end

end
