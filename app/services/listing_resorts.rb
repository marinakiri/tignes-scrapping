class ListingResorts
  attr_accessor :url, :page

  def initialize
    p "hello world !"
    # bob = Classified.new
    # bob.save
  end

  def getDataFromPage
    @url = "https://www.abritel.fr/info/guide/idees/vacances-montagne/vacances-ski/ski-alpes"
    @page = Nokogiri::HTML(open(@url))
    csspath1 = 'table.table.table-condensed ul li a'
    
    elements = page.css(csspath1)

    elements.each do |element|
      puts element.text
      puts element['href']
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