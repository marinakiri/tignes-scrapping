class SidekiqLaunch

  def initialize
    regions = Resort.all.pluck(:region_number)
    # regions = ['66612889','66612807','66612786','66612960','66612917','66612918','66612972','66612919','66612803','66612962'] #Les trois vallées + Tignes et Val d'Isère
    # regions = ['66612889','66612807']
    regions.each do |region|
      
      ScrappingWorker.perform_async(region)
      CalculatingWorker.perform_async(region)
      
    end
  end

end