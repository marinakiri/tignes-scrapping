# class SearchPrice
#   attr_accessor :results, :ville, :number_of_guests

#   def initialize(ville, number_of_guests)
#     @ville = ville
#     @number_of_guests = number_of_guests
#     puts @ville, @number_of_guests
#   end

#   def perform
#     @results= Classified.where("ville":"#{@ville}").where("number_of_guests":"#{@number_of_guests}.to_i")
#     # @results= Classified.where("ville":"#{@ville}").where("number_of_guests":"#{@number_of_guests}.to_i").average("price")
#     puts @results
#   end

# end