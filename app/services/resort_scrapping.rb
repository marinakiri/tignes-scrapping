class ResortScrapping

  attr_accessor :url, :url_dates, :url_pages, :page, :start_date

  def initialize
    p "hello world !"
    # bob = Classified.new
    # bob.save
    @start_date = Date.new
    getDataFromPage
    # changeDate
    # changePage
  end

  def changeResort
  end
 
  def changeDate
    season_start = Date.new(2017,12,9)
    season_end = Date.new(2018,5,5)
    number_of_weeks = (season_end-season_start)/7
    number_of_weeks = number_of_weeks.to_i
    
    binding.pry

    number_of_weeks.times do |i|
      #change url
      @start_date = season_start + (i-1)*7
      @url_dates = "arrival:" + start_date.strftime + "/departure:" + (start_date+7).strftime + "/"
      changePage
    end

  end
  
  def changePage
    puts @url_dates
    @url_pages=""
    # getDataFromPage
    differentPages = true
    counter = 2
    # while differentPages 

    # end 
    binding.pry
    local_old_url = "https://www.abritel.fr/annonces/location-vacances/france_provence-alpes-cote%20d%27azur_4_le%20sauze_dt0.php/"
    new_page = Nokogiri::HTML(open(local_old_url))
    puts new_page.base_uri.to_s

  end

  def getDataFromPage
    
    @url = "https://www.abritel.fr/ajax/map/results/refined/region:66612960/arrival:2017-12-16/departure:2017-12-23/@,,,,z/page:1?view=l&_=1504709646945"
    @page = Nokogiri::HTML(open(@url))

    xpath_name = '//h3[@class="hit-headline"]'
    xpath_url = '//h3[@class="hit-headline"]/a'
    xpath_prices = "//div[@class='rate']/a"
    xpath_guests = '//li[@class="accommodation accommodation--simple bbs-sleeps"]/div[@class="bd-bth-slps-count"]'

    # Old scrapping method

    # #For location use of regex :
    # # reg = /"geography":{"name":(.*)"location"/
    # # reg = /^geography(.*)location$/
    # # reg = /\A"geography".*France","location"\Z/
    # # reg = /\Ageography.*France\Z/
    # # reg = /geography.*France/

    # names = page.xpath(xpath_name)
    # urls = page.xpath(xpath_url)
    # prices = page.xpath(xpath_prices)
    # guests = page.xpath(xpath_guests)

    results_json = JSON.parse(page.text)
    search_results = results_json["results"]["hits"]

    search_results.each do |r|

      Classified.create(
        startDate:@start_date,
        endDate:@start_date+7,
        title:r["headline"],
        price:r["averagePrice"]["value"],
        link:r["detailPageUrl"],
        numberOfGuests:r["sleeps"].to_i
        )
    end

    search_results[0]["sleeps"]

    # binding.pry

    # File.open("page_scrapping.json","w") do |f|
    #   f.write(results_json.to_json)
    # end



    # names.length.times do |i|
    #   Classified.create(startDate:@start_date,
    #     endDate:@start_date+7,
    #     title:names[i-1].text.slice(14..-10),
    #     price:prices[i-1].text.slice(0..-3).to_f,
    #     link:urls[i-1]["href"],
    #     numberOfGuests:guests[i-1].text.to_i)
    # end
    
  end 

end