require 'rubygems'
require 'scrapi'
abcarray = Array.new
abcarray = ["a", "b"]
# ["a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l", "m", "n", "o", "p", "q", "r",
#   "s", "t", "u", "v", "w", "x", "y", "z"]
  
for abc in abcarray
  uri = URI.parse("http://romhustler.net/roms/snes/#{abc}")
  
  
  scraper = Scraper.define do
    array :items
    process "ul.special>li", :items => Scraper.define {
      process "li>a", :title => :text, :link => "@href"
      result :title, :link
    }
    result :items
  end
  
  scraper.scrape(uri).each do |product|
    puts product.title
    puts product.link
    
    uri = URI.parse("http://romhustler.net/#{product.link}")
    scraper_step2 = Scraper.define do
      process "html>body>div:nth-of-type(3)>div:nth-of-type(2)>p:nth-of-type(3)>a:nth-of-type(1)", :link => "@href"
      result :link
    end
    step2_url = scraper_step2.scrape(uri)
    puts step2_url
    
    uri = URI.parse("http://romhustler.net/#{step2_url}")
    scraper_step3 = Scraper.define do
      process "html>body>div:nth-of-type(2)>div:nth-of-type(2)>script:nth-of-type(1)", :javascript => :element
      
      result :javascript
    end
    
     
    step3_url = scraper_step3.scrape(uri)
    puts step3_url
    puts
  end
  

  
end