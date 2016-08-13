module MicropostsHelper

  def get_all_posts()
    @all_posts = Micropost.all

    @all_posts.each do |post|
      post.user = User.find(post[:user_id])
    end

  end

end
