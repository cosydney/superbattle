require 'open-uri'

class PagesController < ApplicationController
  def home
  end
  def stat
    if params[:superuser].nil? || params[:superuser].empty? ||
      params[:usercmp].nil? || params[:usercmp].empty?
      redirect_to root_path, notice: "Username cannot be empty"
    else
      username = params[:superuser]
      usernamecmp = params[:usercmp]
      begin
        @superuser = Superuser.new(username)
        @usercmp = Superuser.new(usernamecmp)
      rescue Capybara::ElementNotFound
        redirect_to root_path, alert: "Username not found"
      end

    end
  end
end
