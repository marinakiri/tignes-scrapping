class SidekiqLaunch

  def initialize
    # regions = Resort.all.pluck(:region_number)
    regions = ['66612786','66612960','66612917','66612918','66612972','66612919','66612803','66612962']

    regions.each do |region|
      ScrappingWorker.perform_async(region)
    end
  end

end