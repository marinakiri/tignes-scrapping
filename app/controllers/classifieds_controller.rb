class ClassifiedsController < ApplicationController
  attr_accessor :average_price

  def index
    @classifieds = Classified.all
  end
  
  def search
    @ville = params[:ville]
    @number_of_guests = params[:number_of_guests]    
    @results= Classified.where("ville":"#{@ville}").where("number_of_guests":"#{@number_of_guests}.to_i")
    build_grid()
  end


  def build_grid
    grid = PivotTable::Grid.new do |g|
      g.source_data = @results
      g.column_name = :title
      g.row_name    = :start_date
      g.value_name  = :price
    end
  end
end
