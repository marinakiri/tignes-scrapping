class ResortScrapping

  attr_accessor :url, :page

  def initialize
    p "hello world !"
    # bob = Classified.new
    # bob.save
    getDataFromPage
  end

  def getDataFromPage
    @url = "https://www.abritel.fr/results/rhone-alpes/champagny-en-vanoise/region:66612899/arrival:2017-12-16/departure:2017-12-23/minSleeps/1"
    @page = Nokogiri::HTML(open(@url))
    xpath_name = '//h3[@class="hit-headline"]'
    xpath_url = '//h3[@class="hit-headline"]/a'
    xpath_prices = '//div[@class="rate"]'
    xpath_rates = "//div[@class='price-overlay']"

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
      puts pr.text
    end

    # puts elements.length
    binding.pry




  end

  def test
    @url = "http://ruby.bastardsbook.com/files/hello-webpage.html"

    #Selection with xpath
    puts "Selecting with xpath"
    #'//*[@id="references"]/p[3]/a'

    @page = Nokogiri::HTML(open(@url))
    xpath1 = '//*[@id="references"]/p[3]/a'

    elements = page.xpath(xpath1)

    elements.each do |element|
      puts element.text
      puts element['href']
    end

    #Selection with xpath
    puts ""
    puts "Now selecting with css"
    links = page.css('div#references a')

    links.each do |link|
      puts "For #{link.text} go to -> #{link['href']}"
    end
  end

end
