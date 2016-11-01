# require 'open-uri'
class PagesController < ApplicationController

  def home
    @superuser = Superuser.new
  end

  def superscore
    @superuser = Superuser.new
  end

  def stat
    if params[:superuser][:insta_username].nil? || params[:superuser][:insta_username].empty? ||
      params[:superuser][:insta_usercomp].nil? || params[:superuser][:insta_usercomp].empty?
      redirect_to root_path
      flash[:notice] = "Username cannot be empty"
    elsif params[:superuser][:insta_username] == params[:superuser][:insta_usercomp]
      redirect_to root_path
      flash[:notice] = "Try to compete with someone else than yourself ;)"
    else
      begin

        create
      rescue Capybara::ElementNotFound
        redirect_to root_path
        flash[:notice] = "Username not found, please check that it exists "
      end
      if @superuser.engagement_rate == 0
        flash[notice] = "You didn't get point for engagement rate because your account is set as private"
      end
      if @usercmp.engagement_rate == 0
        flash[notice] = "Your opponents didn't get point for engagement rate because his account is set as private"
      end
    end
  end

  def create
    @superuser = Superuser.new
    @superuser = Superuser.create(superuser_params)

    # Changing params to make stats for the opponents
    tmp = params[:superuser][:insta_username]
    params[:superuser][:insta_username] = params[:superuser][:insta_usercomp]
    params[:superuser][:insta_usercomp] = tmp
    @usercmp = Superuser.new
    @usercmp = Superuser.create(superuser_params)
  end

  def superuser_params
    params.require(:superuser).permit(:insta_username, :insta_usercomp)
  end

end
