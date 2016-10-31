# require 'open-uri'
class PagesController < ApplicationController

  def home
    @superuser = Superuser.new
  end
  def stat
    if params[:superuser][:insta_username].nil? || params[:superuser][:insta_username].empty? ||
      params[:superuser][:insta_usercomp].nil? || params[:superuser][:insta_usercomp].empty?
      redirect_to root_path, notice: "Username cannot be empty"
    else
      create
    end
  end

    def create
      @superuser = Superuser.new
      @superuser = Superuser.create(superuser_params)
    end

    def superuser_params
      params.require(:superuser).permit(:insta_username, :insta_usercomp)
    end

  end

  # private

  # def scrape_stats
  #   begin
  #     @profile = InstaScrape.user_info(@superuser.insta_username)
  #     @posts = InstaScrape.user_posts(@superuser.insta_username)
  #   rescue Capybara::ElementNotFound
  #     redirect_to root_path, notice: "Username not found"
  #   end
  #   byebug
  #   @superuser.following_count = @profile.following_count.to_i
  #   @superuser.update_number_of_posts = @profile.post_count.to_i
  #   @superuser.image = @profile.image
  #   @superuser.engagement_rate = engagement_rate
  #   @superuser.description = @profile.description
  #   @superuser.followers_count = followers_count.to_i
  #   @superuser.super_score = super_score
  #   @superuser.save!
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

