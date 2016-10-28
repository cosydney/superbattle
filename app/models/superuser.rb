class Superuser < ActiveRecord::Base
  attr_accessor :following_count, :engagement_rate, :follower_count, :post_count, :image, :username, :description

  def initialize(username)
    @profile = InstaScrape.user_info(username)
    @posts = InstaScrape.user_posts(username)
    @following_count = @profile.following_count
    @post_count = @profile.post_count
    @image = @profile.image
    @username = @profile.username
    @engagement_rate = engagement_rate
    @description = @profile.description
    @follower_count = follower_count

    def follower_count
      count = @profile.follower_count
      # instagram will return 10k for 10000 followers.
      if count.include? 'k'
        count = count.gsub('k', '00')
      end
      count = count.scan(/\d*/).join.to_i
      count
    end


    def engagement_rate
      total_like = 0
      @posts.each do |post|
        total_like += post.likes
      end

      engagement_rate = ((total_like / 10.0) / follower_count) * 100
    end

    def self.superbattle_score
      score = engagement_rate * 10
    end
  end
end

