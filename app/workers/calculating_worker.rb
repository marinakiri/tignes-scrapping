class CalculatingWorker

  include Sidekiq::Worker

  SEASON_START    = Date.new(2017, 12, 9)
  SEASON_END      = Date.new(2018, 5, 5)

  def initialize

  end

  def perform(region)

    r = Resort.find_by_region_number(region)

    (SEASON_START...SEASON_END).step(7).each do |date|
            
      classifieds = Classified.where(resort:r).where(start_date:date)
      
      if classifieds != []
        classifieds.group('number_of_guests').pluck('number_of_guests').each do |ng|

          #either find an existing entry or create one
          if Average.where(resort:r).where(start_date:date).find_by_number_of_guests(ng) != nil
            average_entry = Average.where(resort:r).where(start_date:date).find_by_number_of_guests(ng)
            puts "entry already exists, just updating it"
          else  
            average_entry = Average.new
          end 

          average_entry.start_date = date
          average_entry.average_value = classifieds.average('price')
          average_entry.average_count = classifieds.count
          average_entry.resort = r
          average_entry.number_of_guests = ng
          average_entry.save

        end
      end

    end

  end

end