require 'open-uri'

class PagesController < ApplicationController
  def home
  end
  def stat
    if params[:answer].nil? || params[:answer].empty?
      redirect_to root_path
    else
      @username = params[:answer]
      @profile = InstaScrape.user_info(@username)
      @posts = InstaScrape.user_posts(@username)
      @likes = scrape_insta_likes("https://www.instagram.com/p/BK2ePMmhz9g/")
    end
  end

  def scrape_insta_likes(url)
    doc = Nokogiri::HTML(open(url))
    likes = doc.search.xpath('likes')
    likes
  end

end
