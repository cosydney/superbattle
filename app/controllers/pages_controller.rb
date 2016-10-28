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
    end
  end
end
