require "open-uri"
require "nokogiri"

doc = Nokogiri::HTML(open('https://www.etsy.com/search?q=wallet'))
doc.search('.card-title').each_with_index do |element, index|
  puts "#{index}. #{element.text.strip}"
end