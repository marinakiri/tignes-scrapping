class Analysis

  def initialize
    #Récupérer les prix moyens à la nuit de chaque semaine par nombre de guests
    average_prices = Classified.group("ville").group("start_date").group("number_of_guests").average("price")  

    #Récupérer les valeurs pour une requête spécifique (ici Vaujany avec 8 guests)
    Classified.where("ville":"vaujany").group("start_date").where("number_of_guests":4).average("price")

    #Connaître le nomre de résultats qui ont permis de calculer les averages
    Classified.where("ville":"vaujany").group("start_date").where("number_of_guests":4).count

    #Get the list of id of elements to display as a result
    Classified.where("ville":"vaujany").where("number_of_guests":4).pluck("id")
  end

end