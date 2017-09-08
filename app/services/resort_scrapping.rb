class ResortScrapping

  attr_accessor :url, :url_fix_first, :url_fix_second, :url_dates, :url_region, :url_pages, :start_date, :double

  def initialize
    p "Let's scrap the classifieds!"
    # bob = Classified.new
    # bob.save
    @start_date = Date.new

    @url_fix_first = "https://www.abritel.fr/ajax/map/results/refined"
    @url_region = "/region:66612960"
    @url_dates = "/arrival:2017-12-16/departure:2017-12-23"
    @url_fix_second = "/@,,,,z"
    @url_pages = "/page:1"

    @double = 0

    build_url
     
    changeResort
    # getDataFromPage
    puts "number of duplicates avoided: #{@double}"
    
  end

  def build_url
    @url = @url_fix_first + @url_region + @url_dates + @url_fix_second + @url_pages
  end

  def changeResort

    region_id_list = Resort.pluck(:region_number)
    
    region_id_list.each do |region_id| #Adding the [0..3] to limit the number of tests
     @url_region = "/region:#{region_id}"
     build_url
     puts "*Scrapping for region #{region_id}*"
     changeDate
   end
  end
 
  def changeDate
    season_start = Date.new(2017,12,9)
    season_end = Date.new(2017,12,16) #Here change the season end to increase tests
    number_of_weeks = (season_end-season_start)/7
    number_of_weeks = number_of_weeks.to_i

    number_of_weeks.times do |i|
      #change url
      @start_date = season_start + (i-1)*7
      @url_dates = "/arrival:" + start_date.strftime + "/departure:" + (start_date+7).strftime + "/"
      build_url
      puts "***Scrapping for starting date #{@start_date}***"
      changePage
    end

  end
  
  def changePage

    #Getting the total number of pages to scrap
    @url_pages = "/page:1"
    build_url
    page = HTTParty.get(@url)
    current_number_of_pages = JSON.parse(page.body)["results"]["pageCount"]

    # current_number_of_pages = 1 #just to test with fewer pages
    puts current_number_of_pages
    (current_number_of_pages-1).times do |i|
      puts "*****Scrapping page number #{i+1} of week starting #{@start_date}*****"
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
        if (Classified.find_by_abritel_classified_id(r["listingId"]) == nil || Classified.find_by_abritel_classified_id(r["listingId"]).start_date != @start_date)
          Classified.create(
            start_date:@start_date,
            end_date:@start_date+7,
            title:r["headline"],
            price:r["averagePrice"]["value"],
            link:r["detailPageUrl"],
            number_of_guests:r["sleeps"].to_i,
            abritel_id:r["listingNumber"].to_i,
            abritel_classified_id:r["listingId"]
            )
        else
          @double += 1
          puts "!!! already in database !!!"
        end
      end
    end
  end 

end