class CalculatingWorker

  include Sidekiq::Worker

  SEASON_START    = Date.new(2017, 12, 9)
  SEASON_END      = Date.new(2018, 5, 5)

  def initialize

  end

  def perform(region)

    r = Resort.find_by_region_number(region)

    (SEASON_START...SEASON_END).step(7).each do |date|
      
      #either find an existing entry or create one
      if Average.where(resort:r)
        average_entry = Average.where(resort:r)
      else  
        average_entry = Average.new
      end

      classifieds = Classified.where(resort:r).where(start_date:date)
      
      average_entry.start_date    = date
      average_entry.average_value = classifieds.average('price')
      average_entry.average_count = classifieds.count
      average_entry.resort        = r

    end

  end

end