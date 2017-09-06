class ClassifiedsController < ApplicationController
  
  def index
    @classifieds = Classified.all
  end
  
end
