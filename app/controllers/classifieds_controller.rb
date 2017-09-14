class ClassifiedsController < ApplicationController
  attr_accessor :current_ville

  def index
    @classifieds = Classified.all
  end
  
  def search
    @classifieds = Classified.all
    @ville = params[:ville]
    @current_ville = @ville
    @number_of_guests = params[:number_of_guests]    
    @results= Classified.where("ville":"#{@current_ville}").where("number_of_guests":"#{@number_of_guests}.to_i").order("start_date")
    # SearchPrice.new(@ville, @number_of_guests).perform unless (@ville == nil || @number_of_guests == nil)
    # @average_price = Classified.where("ville":"#{@ville}").where("number_of_guests":"#{@number_of_guests}.to_i").average("price")
    @averages = Classified.where("ville":params[:current_ville]).group("start_date").where("number_of_guests":params[:number_of_guests]).average("price")
    @counts = Classified.where("ville":params[:current_ville]).group("start_date").where("number_of_guests":params[:number_of_guests]).count
  end

end
