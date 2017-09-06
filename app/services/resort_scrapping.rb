class ResortScrapping

  attr_accessor :url, :page

  def initialize
    p "hello world !"
    # bob = Classified.new
    # bob.save
    getDataFromPage
  end

  def changeResort
  end
 
  def changeDate

  end
  
  def changePage
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
