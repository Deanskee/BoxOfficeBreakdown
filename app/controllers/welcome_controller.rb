class WelcomeController < ApplicationController
  def index
  	# Scraping that calls the css class wrap for title and weekend amount and iterates from the top 5 for the weekend
    url = "https://search.yahoo.com/search?p=movie+weekend+box+office&toggle=1&cop=mss&ei=UTF-8&fr=yfp-t-901"
    doc = Nokogiri::HTML(open(url))

    listings = Array.new

  
    doc.css(".wrap").each do |item|
      @title = item.at_css(".c-styl-5").text
      # so we have a title
      dot_idx = @title.index(". ")
      # below calls the actual amount from the scrape and stores it in the actual amount under movies model. 
      if dot_idx && dot_idx >= 0
        puts "*********** " + @title.inspect
        this_movie = Movie.where("title like ?", "%"+@title[(dot_idx + 2)..-1]).first
        @box = item.at_css(".c-styl-8").text
         puts "we found it!" + @title + "x"
         # Needed to take out the $, the , and the . symbol from the scrape so it would store the actual weekend box office amount
         
         amt = @box.gsub('$', '').gsub(',', '').to_i
         # amt is taking the movie and spitting it to my database

         if this_movie
          this_movie.actual_amount = amt
          this_movie.save
         else
          Movie.create(title: @title[(dot_idx + 2)..-1], actual_amount:amt)
         end
        listings << [@title, @box]
       end
	end
  
    # This takes the top 5 from the weekend box office amount
    # Below is comparing the guess amount from the week prior to the actual amount and sorting the guesses stored as a and b
     last_week= Guess.where( :created_at => Date.commercial(Date.today.year, Date.today.cweek - 1, 1) ... Date.commercial(Date.today.year, Date.today.cweek, 1))
     last_week.each do |g|
       if g.movie 
       g.amount = (g.movie.actual_amount - g.amount).abs
        
     end
  end

     last_week.sort_by{|x| x[:amount]}
      @listings = last_week[0..4]
      # raise last_week.map(&:id).inspect
  end
end
