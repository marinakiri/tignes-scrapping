class ResortScrapping

  attr_accessor :url, :page

  def initialize
    p "hello world !"
    # bob = Classified.new
    # bob.save
  end

  def getDataFromPage
    @url = "https://www.abritel.fr/results/rhone-alpes/champagny-en-vanoise/region:66612899/arrival:2017-12-16/departure:2017-12-23/minSleeps/1"
    @page = Nokogiri::HTML(open(@url))
    xpath1 = '//h3[@class="hit-headline"]'

    elements = page.xpath(xpath1)

    elements.each do |element|
      puts element.text
      # puts element['href']
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
