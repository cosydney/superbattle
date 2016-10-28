class InstaScrape::InstagramPost
  attr_accessor :link, :likes #,:image
  def initialize(link, likes) #, image)
    # @image = image
    @link = link
    @likes = likes
  end
end
