module ClassifiedsHelper
  def list_station
    villes = []
    #take all ville in an array
    villes += Classified.group("ville").order("ville").pluck("ville")
    #iterate over the array
    list_of_station = []
    villes.each do |i|
        if Classified.where("ville":"#{i}").count > 10
          list_of_station.push(i)
        end
      end
    return(list_of_station)
  end
end
