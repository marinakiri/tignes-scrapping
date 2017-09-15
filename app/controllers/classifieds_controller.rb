class ClassifiedsController < ApplicationController
  attr_accessor :current_ville

  def index
    @classifieds = Classified.all
    @search = Search.find(1)
    if params[:ville]
      @search.ville = params[:ville]
    end
    if params[:number_of_guests] 
      @search.number_of_guests = params[:number_of_guests] 
    end
    @search.save   

    @classifieds = Classified.all

    @results= Classified.where("ville":@search.ville).where("number_of_guests":@search.number_of_guests.to_i).order("start_date")
    # SearchPrice.new(@ville, @number_of_guests).perform unless (@ville == nil || @number_of_guests == nil)
    # @average_price = Classified.where("ville":"#{@ville}").where("number_of_guests":"#{@number_of_guests}.to_i").average("price")
    @averages = Classified.where("ville":@search.ville).where("number_of_guests":@search.number_of_guests.to_i).group("start_date").average("price")
    @counts = Classified.where("ville":@search.ville).where("number_of_guests":@search.number_of_guests.to_i).group("start_date").count
  end

  def search
    @classifieds = Classified.all
    @search = Search.find(1)
    if params[:ville]
      @search.ville = params[:ville]
    end
    if params[:number_of_guests] 
      @search.number_of_guests = params[:number_of_guests] 
    end
    @search.save   

    @results= Classified.where("ville":@search.ville).where("number_of_guests":@search.number_of_guests.to_i).order("start_date")
    # SearchPrice.new(@ville, @number_of_guests).perform unless (@ville == nil || @number_of_guests == nil)
    # @average_price = Classified.where("ville":"#{@ville}").where("number_of_guests":"#{@number_of_guests}.to_i").average("price")
    @averages = Classified.where("ville":@search.ville).where("number_of_guests":@search.number_of_guests.to_i).group("start_date").average("price")
    @counts = Classified.where("ville":@search.ville).where("number_of_guests":@search.number_of_guests.to_i).group("start_date").count
  end

end
