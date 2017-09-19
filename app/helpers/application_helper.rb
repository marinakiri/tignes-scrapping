module ApplicationHelper
  def list_station
    #take all ville in an array
    villes = Classified.group("ville").order("ville").pluck("ville")
    #iterate over the array
    list_of_station = []
    regions = ['66612889','66612807','66612786','66612960','66612917','66612918','66612972','66612919','66612803','66612962'] #Les trois vallées + Tignes et Val d'Isère

    villes.each do |i|
      if Resort.find_by_ville(I18n.transliterate(i))
         if Classified.where("ville":"#{i}").count > 10 && (regions.include? Resort.find_by_ville(I18n.transliterate(i)).region_number)
           list_of_station.push(titleize(i))
        end
      end
    end

    return(list_of_station)

  end

  def list_of_number_of_guests
      return Classified.where(ville:@search.ville).group("number_of_guests").count.keys
  end

  def titleize(title)
    new_title = ""

    title.split.each do |word|
      if new_title == ""
        new_title << word.capitalize
      elsif ["les", "le", "de"].include? word
        new_title << " "
        new_title << word
      elsif ["d'isere"].include? word
        new_title << " "
        new_title << "d'Isere"
      else  
        new_title << " "
        new_title << word.capitalize
      end
    end

    return new_title
  end


end


