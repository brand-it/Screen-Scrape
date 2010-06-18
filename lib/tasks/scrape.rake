

require 'rubygems'
require 'scrapi'
namespace :scrape do
  desc "Pulling data from the web site"
  task :website => :environment do

    abcarray = Array.new
    systems = Array.new
    systems = ["nes", "snes"]
    abcarray = ["a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l", "m", "n", "o", "p", "q", "r",
          "s", "t", "u", "v", "w", "x", "y", "z"]
    
    Download.destroy_all
    for system in systems
      puts system
      for abc in abcarray
        uri = URI.parse("http://romhustler.net/roms/#{system}/#{abc}")
  
  
        scraper = Scraper.define do
          array :items
          process "ul.special>li", :items => Scraper.define {
            process "li>a", :title => :text, :linkone => "@href"
            result :title, :linkone
          }
          result :items
        end
  
        scraper.scrape(uri).each do |product|
    
          #Adds the information to the db
    
          uri = URI.parse("http://romhustler.net/#{product.linkone}")
          scraper_step2 = Scraper.define do
            process "html>body>div:nth-of-type(3)>div:nth-of-type(2)>p:nth-of-type(3)>a:nth-of-type(1)", :linktwo => "@href"
            result :linktwo
          end
          step2_url = scraper_step2.scrape(uri)
    
        
          @download = Download.new(:title => product.title, :url_one => product.linkone, :url_two => step2_url, :system => system)
    
          if @download.save
            puts product.title + "has been added to the db"
          else
            puts "Could not add item see debug information"
          end
        end
      end
    end
  end
end