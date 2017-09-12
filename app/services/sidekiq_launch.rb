class SidekiqLaunch

  def initialize
    regions = Resort.all.pluck(:region_number)

    regions.each do |region|
      ScrappingWorker.perform_async(region)
    end
  end

end