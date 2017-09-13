class SidekiqLaunch

  def initialize
    regions = Resort.all.pluck(:region_number)
    regions = regions.shuffle

    regions.each do |region|
      # ScrappingWorker.perform_async(region)
      ScrappingWorker.new.perform(region)
    end
  end

end