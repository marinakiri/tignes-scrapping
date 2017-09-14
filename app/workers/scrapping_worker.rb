class ScrappingWorker
  include Sidekiq::Worker

  attr_accessor :double,
                :region

  URL_FIX_FIRST   = 'https://www.abritel.fr/ajax/map/results/refined'
  URL_FIX_SECOND  = '/@,,,,z'
  SEASON_START    = Date.new(2017, 12, 9)
  SEASON_END      = Date.new(2018, 5, 5)

  def initialize
    self.double     = 0
  end

  def perform(region)
    Sidekiq.logger.info "*Scrapping for region #{region}*"

    self.region     = region

    (SEASON_START...SEASON_END).step(7).each do |date|
      Sidekiq.logger.info "--**--**--**--**--**--**--**--**Scrapping for starting date #{date}**--**--**--**--**--**--**--**--"

      page = 1

      loop do
        json = HTTParty.get(url(date, page)).parsed_response
        Sidekiq.logger.info url(date, page)
        Sidekiq.logger.info "-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-Scrapping page #{page}-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-"
        get_data_from_json(date, json)

        break if page >= json['results']['pageCount']
        page += 1
      end
    end


    Sidekiq.logger.info "number of duplicates avoided: #{self.double}"
  end

  def get_data_from_json(date, results_json)

    search_results = results_json['results']['hits']

    search_results.each do |r|
      if r['averagePrice'] && r['headline'] && r['detailPageUrl'] && r["geography"]["ids"][1]
        if Classified.find_by(abritel_classified_id: r["listingId"], start_date: date)
          @double += 1
          Sidekiq.logger.info "------------------!!! already in database !!!------------------"
          next
        end

        geography = r['regionPathHierarchy'].split(':')

        c = Classified.new(
            start_date:             date,
            end_date:               date + 7,
            title:                  r["headline"],
            price:                  r["averagePrice"]["value"],
            link:                   r["detailPageUrl"],
            number_of_guests:       r["sleeps"].to_i,
            abritel_id:             r["listingNumber"].to_i,
            abritel_classified_id:  r["listingId"],
            country:                geography[0],
            region:                 geography[1],
            departement:            geography[2],
            ville:                  geography[3],
            quartier:               geography[4],
            region_number:          r["geography"]["ids"][1]["value"] 
        )
        
        if Resort.find_by_region_number(c['region_number'])
            c.resort = Resort.find_by_region_number(c['region_number'])
          else
            Resort.create(region_number:c['region_number'],ville:c['ville'],ville_url:URI.escape(c['ville']))
            c.resort = Resort.last
            Sidekiq.logger.info "-*-*-*-New Resort created-*-*-*-"
        end
        c.save
    end
  end
  end


  private
  def url(date, page)
    "#{URL_FIX_FIRST}#{region_url_part}#{date_url_part(date)}#{URL_FIX_SECOND}#{page_url_part(page)}"
  end

  def region_url_part
    "/region:#{region}"
  end

  def date_url_part(date_begin)
    "/arrival:#{date_begin}/departure:#{date_begin + 7}"
  end

  def page_url_part(page)
    "/page:#{page}"
  end
end