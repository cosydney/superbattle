require 'open-uri'

class PagesController < ApplicationController
  def home
  end
  def stat
    if params[:answer].nil? || params[:answer].empty?
      redirect_to root_path
    else
      @username = params[:answer]
      @superuser = Superuser.new(@username)
      # @superusercmp = Superuser.new()
    end
  end
end
