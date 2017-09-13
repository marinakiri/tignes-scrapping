villes = []
#take all ville in an array
villes += Classified.group("ville").order("ville").pluck("ville")
#iterate over the array

list_of_station = []
MIN_NUMBER = 10
  villes.each do |i|
    if Classified.where("ville":"#{i}").count > MIN_NUMBER
      list_of_station.push(i)
    end
  end
