class Superuser < ActiveRecord::Base
  attr_accessor :following_count, :engagement_rate, :followers_count, :number_of_posts, :image, :insta_username, :description
  # validates :insta_username, :insta_usercmp, presence :true
  # after_create :scrape_insta

  # def scrape_insta
  #   begin
  #     @profile = InstaScrape.user_info(@superuser.insta_username)
  #     @posts = InstaScrape.user_posts(@superuser.insta_username)
  #   rescue Capybara::ElementNotFound
  #     redirect_to root_path, notice: "Username not found"
  #   end
  #   self.following_count = @profile.following_count
  #   self.number_of_posts = @profile.post_count
  #   self.image = @profile.image
  #   self.engagement_rate = engagement_rate
  #   self.description = @profile.description
  #   self.followers_count = followers_count
  #   self.super_score = super_score
  # end

  # def followers_count
  #   count = @profile.follower_count
  #     # instagram will return 10k for 10000 followers.
  #     if count.include? 'k'
  #       count = count.gsub('k', '00')
  #     end
  #     count = count.scan(/\d*/).join.to_i
  #     count
  #   end


  #   def engagement_rate
  #     total_like = 0
  #     @posts.each do |post|
  #       total_like += post.likes
  #     end
  #     engagement_rate = ((total_like / 10.0) / followers_count) * 100
  #   end

  #   def super_score
  #     @superuser.engagement_rate * 10
  #   end


  # def initialize(username)
  #   @profile = InstaScrape.user_info(username)
  #   @posts = InstaScrape.user_posts(username)
  #   @following_count = @profile.following_count
  #   @post_count = @profile.post_count
  #   @image = @profile.image
  #   @username = @profile.username
  #   @engagement_rate = engagement_rate
  #   @description = @profile.description
  #   @follower_count = follower_count
  # end


  # def self.followers_count
  #   count = @profile.followers_count
  #     # instagram will return 10k for 10000 followers.
  #     if count.include? 'k'
  #       count = count.gsub('k', '00')
  #     end
  #     count = count.scan(/\d*/).join.to_i
  #     count
  #   end


  #   def self.engagement_rate
  #     total_like = 0
  #     @posts.each do |post|
  #       total_like += post.likes
  #     end

  #     engagement_rate = ((total_like / 10.0) / followers_count) * 100
  #   end

  #   def self.super_score
  #     engagement_rate * 10
  #   end
end

