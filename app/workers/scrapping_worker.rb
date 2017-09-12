class ScrappingWorker
  include Sidekiq::Worker

  attr_accessor :double,
                :region

  URL_FIX_FIRST   = 'https://www.abritel.fr/ajax/map/results/refined'
  URL_FIX_SECOND  = '/@,,,,z'
  SEASON_START    = Date.new(2017, 12, 9)
  SEASON_END      = SEASON_START + 14

  def perform(region)
    Sidekiq.logger.info "*Scrapping for region #{region}*"

    self.double     = 0
    self.region     = region

    (SEASON_START...SEASON_END).step(7).each do |date|
      puts "***Scrapping for starting date #{date}***"

      page = 1

      loop do
        json = HTTParty.get(url(date, page)).parsed_response

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
      if r['averagePrice'] && r['headline'] && r['detailPageUrl']
        if Classified.find_by(classified_id: r["listingId"], start_date: date).exists?
          @double += 1
          Sidekiq.logger.info "!!! already in database !!!"
          next
        end

        geography = r['regionPathHierarchy'].split(':')

        Classified.create(
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
            quartier:               geography[4]
        )
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