class Superuser < ActiveRecord::Base
  after_create :scrape_insta

  def scrape_insta
    @profile = InstaScrape.user_info(self.insta_username)
    @posts = InstaScrape.user_posts(self.insta_username)
    self.following_count = @profile.following_count.to_i
    self.number_of_posts = @profile.post_count
    self.image = @profile.image
    self.engagement_rate = engagement_rate
    self.description = @profile.description
    self.followers_count = followers_count
    self.super_score = super_score
    # self.save
  end

  def followers_count
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
      engagement_rate = ((total_like / 10.0) / followers_count) * 100
    end

    def super_score
      self.engagement_rate * 10
    end
  end
