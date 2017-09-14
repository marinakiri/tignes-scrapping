
class ListingResorts
  attr_accessor :region_hash

  def initialize
    p "Let's get the region code from all French ski Resorts!"
    @region_hash = {}
    get_regions_of_resorts
  end
  
  def get_regions_of_resorts
    
    region_links=[]
    # urls = ["https://www.abritel.fr/info/guide/idees/vacances-montagne/vacances-ski/ski-alpes",
    #   "https://www.abritel.fr/info/guide/idees/vacances-montagne/vacances-ski/ski-pyrenees",
    #   "https://www.abritel.fr/info/guide/idees/vacances-montagne/vacances-ski/ski-massif-central",
    #   "https://www.abritel.fr/info/guide/idees/vacances-montagne/vacances-ski/ski-vosges-jura"]
      urls = ['https://www.abritel.fr/info/guide/idees/vacances-montagne/vacances-ski']
    urls.each do |url|
      resp = HTTParty.get(url); nil
      region_links = region_links + resp.split("\n").grep(/<li><a href="\/annonces\/location-vacances\/.*php/).map{|href| href.split("\"")[1]}
    end
    
    region_links.each do |region_link|
      get_regions_from_links(region_link)
    end

  end

  def get_regions_from_links(region_link)
    link = "https://www.abritel.fr" + region_link
    puts region_link
    if link =~ URI::regexp
      resp = HTTParty.get(link); nil
      if resp.split("\n").grep(/<link rel=\"next\"/)[0] != nil && Resort.find_by_region_number(region_link) == nil
        current_resort = Resort.new
        current_resort.url = link
        current_resort.region_number = resp.split("\n").grep(/<link rel=\"next\"/)[0].split("/")[4].split(":")[1]
        current_resort.save
      elsif Resort.find_by_region_number(region_link) != nil
        puts "already in database"
      end
    else
      puts "not valid url"
    end
  end

end