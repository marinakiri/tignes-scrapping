module ClassifiedsHelper
  def list_station
<<<<<<< HEAD
    all_stations = Classified.group("ville").order("ville").pluck("ville")
=======
    #take all ville in an array
    villes = Classified.group("ville").order("ville").pluck("ville")
>>>>>>> master
    #iterate over the array
    list_of_station = []
    all_stations.each do |i|
        if Classified.where("ville":"#{i}").count > 10
          list_of_station.push(i)
        end
      end
    return(list_of_station)
  end

  def list_guest
    all_guests=[]

    guests_hash = Classified.where("ville":params[:ville]).group("number_of_guests").count
    guests_hash.each do |u,v|
      guests.push(u.to_s) if v > 10
    end
    return(all_guests)
  end
end
