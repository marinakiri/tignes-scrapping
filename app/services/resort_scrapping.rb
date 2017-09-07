class ResortScrapping

  attr_accessor :url, :url_fix_first, :url_fix_second, :url_dates, :url_pages, :start_date

  def initialize
    p "hello world !"
    # bob = Classified.new
    # bob.save
    @start_date = Date.new

    @url_fix_first = "https://www.abritel.fr/ajax/map/results/refined"
    @url_region = "/region:66612960"
    @url_dates = "/arrival:2017-12-16/departure:2017-12-23"
    @url_fix_second = "/@,,,,z"
    @url_pages = "/page:1"

    puts build_url
    puts "https://www.abritel.fr/ajax/map/results/refined/region:66612960/arrival:2017-12-16/departure:2017-12-23/@,,,,z/page:1"
    puts build_url == "https://www.abritel.fr/ajax/map/results/refined/region:66612960/arrival:2017-12-16/departure:2017-12-23/@,,,,z/page:1"
    
    changeDate
    # getDataFromPage
    
  end

  def build_url
    @url = @url_fix_first + @url_region + @url_dates + @url_fix_second + @url_pages
  end

  def changeResort

  end
 
  def changeDate
    season_start = Date.new(2017,12,9)
    season_end = Date.new(2018,2,17)
    number_of_weeks = (season_end-season_start)/7
    number_of_weeks = number_of_weeks.to_i

    number_of_weeks.times do |i|
      #change url
      @start_date = season_start + (i-1)*7
      @url_dates = "arrival:" + start_date.strftime + "/departure:" + (start_date+7).strftime + "/"
      changePage
    end

  end
  
  def changePage

    #Getting the total number of pages to scrap
    page = HTTParty.get(@url)
    current_number_of_pages = JSON.parse(page.body)["results"]["pageCount"]

    current_number_of_pages = 2 #just to test with fewer pages

    current_number_of_pages.times do |i|
        @url_pages = "/page:#{i+1}"
        build_url
        getDataFromPage
    end

  end

  def getDataFromPage
    
    page = HTTParty.get(@url)
    puts @url
    sleep(3)
    results_json = JSON.parse(page.body)
    search_results = results_json["results"]["hits"]

    search_results.each do |r|
      if (r["averagePrice"]!=nil && r["headline"]!=nil && r["detailPageUrl"]!=nil) 
      Classified.create(
        startDate:@start_date,
        endDate:@start_date+7,
        title:r["headline"],
        price:r["averagePrice"]["value"],
        link:r["detailPageUrl"],
        numberOfGuests:r["sleeps"].to_i
        )
      end
    end
  end 

end