require 'nokogiri'
require 'open-uri'


url_top = "https://www.imdb.com/chart/top" # get the url of the website you want to scrape 
html = URI.open(url_top).read # open file and convert it into a string with the read method

doc = Nokogiri::HTML(html) # convert the html file string into a Nokogiri document

# 1. Get to5 5 movies by scraping
# nokogiri scraping
top_movies = []

5.times do |num| # iterate five times 5 times
    title = doc.search(".titleColumn a")[num].text # get title with nokogiri search method applied on the document
    link = doc.search(".titleColumn a")[num].attribute("href").value # get link url sufix with nokogiri search method applied on the document
    top_movies << { title: title, 
                    link: link
                  } 
end

# 2. got to show page of each movie and extract rest of info
top_movies.each do |item| # iterate over the top movies array
    puts item[:title]

    show_url_base = "https://www.imdb.com/#{item[:link]}" # get the link and create a new url for scraping the show page for each movie

    html_show = URI.open(show_url_base).read # open and store html file into a string

    doc_show = Nokogiri::HTML(html_show) # create a Nokogiri document out of html string

    
    p "Director: #{doc_show.search(".ipc-metadata-list__item:contains('Director') a")[0].text}" # Nokogiri search to find director
    # we use the containes method to look for the element that containes the text passed to the method

    # Nokogiri search to find cast
    p "Cast:"
    doc_show.search(".ipc-metadata-list-item--link:contains('Stars') .ipc-metadata-list-item__content-container ul li a").each do |link|
        p "- #{link.text}"
    end

    p "========================================================"
end
# ipc-metadata-list-item__list-content-item--link

# open-uri open websites and get html



# 3. store reasuts in yml file