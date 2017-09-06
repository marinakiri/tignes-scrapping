class ResortScrapping

  attr_accessor :url, :url_dates, :page

  def initialize
    p "hello world !"
    # bob = Classified.new
    # bob.save
    # getDataFromPage
    changeDate
  end

  def changeResort
  end
 
  def changeDate
    season_start = Date.new(2017,12,9)
    season_end = Date.new(2018,5,5)
    number_of_weeks = (season_end-season_start)/7
    number_of_weeks = number_of_weeks.to_i
    start_date = Date.new

    number_of_weeks.times do |i|
      #change url
      start_date = season_start + (i-1)*7
      @url_dates = "arrival:" + start_date.strftime + "/departure:" + (start_date+7).strftime + "/"
      changePage
    end

  end
  
  def changePage
    puts @url_dates
  end

  def getDataFromPage
    @url = "https://www.abritel.fr/results/rhone-alpes/champagny-en-vanoise/region:66612899/arrival:2017-12-16/departure:2017-12-23/minSleeps/1"
    @page = Nokogiri::HTML(open(@url))
    xpath_name = '//h3[@class="hit-headline"]'
    xpath_url = '//h3[@class="hit-headline"]/a'
    # xpath_prices = '//div[@class="rate"]'
    xpath_prices = "//div[@class='rate']/a"

    names = page.xpath(xpath_name)
    urls = page.xpath(xpath_url)
    prices = page.xpath(xpath_prices)
    # prices does return an empty array for now, several unsucessful attempts, next step try using a regex and collect of bigger split of raw html

    names.each do |n|
      puts n.text.slice(14..-10)
      # puts element['href']
    end

    urls.each do |u|
      puts u["href"]
    end

    prices.each do |pr|
      puts pr.text.slice(0..-3).to_f
    end

    # puts elements.length
    binding.pry
  end 

end
to -> #{link['href']}"
    end
  end

end
