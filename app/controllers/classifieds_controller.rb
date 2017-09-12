class ClassifiedsController < ApplicationController
  attr_accessor :average_price

  def index
    @classifieds = Classified.all
  end
  
  def search
    @ville = params[:ville]
    @number_of_guests = params[:number_of_guests]    
    @results= Classified.where("ville":"#{@ville}").where("number_of_guests":"#{@number_of_guests}.to_i")
    # SearchPrice.new(@ville, @number_of_guests).perform unless (@ville == nil || @number_of_guests == nil)
    @average_price = Classified.where("ville":"#{@ville}").where("number_of_guests":"#{@number_of_guests}.to_i").average("price")
  end

end
