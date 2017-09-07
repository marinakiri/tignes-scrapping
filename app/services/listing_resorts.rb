
class ListingResorts
  attr_accessor :region_hash

  def initialize
    p "hello world !"
    @region_hash = {}
    get_regions_of_resorts
  end
  
  def get_regions_of_resorts
    
    region_links=[]
    urls = ["https://www.abritel.fr/info/guide/idees/vacances-montagne/vacances-ski/ski-alpes",
      "https://www.abritel.fr/info/guide/idees/vacances-montagne/vacances-ski/ski-pyrenees",
      "https://www.abritel.fr/info/guide/idees/vacances-montagne/vacances-ski/ski-massif-central",
      "https://www.abritel.fr/info/guide/idees/vacances-montagne/vacances-ski/ski-vosges-jura"]
    urls.each do |url|
      resp = HTTParty.get(url); nil
      region_links << resp.split("\n").grep(/<li><a href="\/annonces\/location-vacances\/.*php/).map{|href| href.split("\"")[1]}
    end
    binding.pry
    region_links.each do |region_link|
      get_regions_from_links(region_link.to_s)
    end

    puts @region_hash
  end

  def get_regions_from_links(link)
    resp = HTTParty.get(link);
    @region_hash[link]=resp.split("\n").grep(/<link rel=\"next\"/)[0].split("/")[4].split(":")[1]
  end


end