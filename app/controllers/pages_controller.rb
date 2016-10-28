require 'open-uri'

class PagesController < ApplicationController
  def home
  end
  def stat
    if params[:superuser].nil? || params[:superuser].empty? ||
      params[:usercmp].nil? || params[:usercmp].empty?
      redirect_to root_path
    else
      username = params[:superuser]
      usernamecmp = params[:usercmp]
      @superuser = Superuser.new(username)
      @usercmp = Superuser.new(usernamecmp)
    end
  end
end
