 require "instagram"
    Instagram.configure do |config|
    config.client_id = ENV["INSTA_CLIENT_ID"]
    config.access_token = ENV["INSTA_ACCESS_TOKEN"]
 end