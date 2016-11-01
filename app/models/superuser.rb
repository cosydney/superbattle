class Superuser < ActiveRecord::Base
  after_create :scrape_insta

  def scrape_insta
    @profile = InstaScrape.user_info(self.insta_username)
    @posts = InstaScrape.user_posts(self.insta_username)
    self.following_count = @profile.following_count.scan(/\d*/).join.to_i
    self.number_of_posts = @profile.post_count.scan(/\d*/).join.to_i
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
    if (@posts == nil)
      engagement_rate = 0
    else
      @posts.each do |post|
        total_like += post.likes
      end
      engagement_rate = ((total_like / 10.0) / followers_count) * 100
      engagement_rate.round(2)
    end
  end

  def super_score
      # getting points for number of followers
      score = case self.followers_count
      when 0..500 then 2
      when 500..800 then 3.5
      when 800..1000 then 7
      when 1000..3000 then 10.5
      when 3000..7000 then 14
      when 7000..10000 then 17.5
      when 10000..30000 then 21
      when 30000..60000 then 24.5
      when 90000..150000 then 28
      when 150000..200000 then 31.5
      when 200000..9000000000 then 35
      end
      # getting points for number of following
      if self.following_count >= 200
        score += 2
      end
      if self.following_count < 1000
        score +=2
      end
      if self.following_count < self.followers_count
        score += 6
      end
      # getting points for number of posts
      score += case self.number_of_posts
      when 0..10 then 2
      when 10..100 then 4
      when 300..600 then 6
      when 600..1000 then 8
      when 1000..50000 then 10
      end
      # getting points for description length
      score += case self.description.length
      when 0..10 then 2.5
      when 10..30 then 5
      when 30..80 then 7.5
      when 80..300 then 10
      end
      # Getting points for engagement rate
      if self.followers_count < 500
        score += case self.engagement_rate.round
        when 0..5 then 7
        when 5..25 then 14
        when 25..40 then 21
        when 40..60 then 28
        when 80..1000 then 35
        end
      elsif self.followers_count >= 500 && self.followers_count <= 5000
        score += case self.engagement_rate.round
        when 2..4 then 7
        when 4..7 then 14
        when 7..10 then 21
        when 10..15 then 28
        when 15..1000 then 35
        end
      else #self.followers_count >= 5000
        score += case self.engagement_rate.round
        when 0..1 then 3
        when 1..2 then 7
        when 2..4 then 14
        when 4..7 then 21
        when 7..10 then 28
        when 10..1000 then 35
        end
      end
      score
    end
  end


