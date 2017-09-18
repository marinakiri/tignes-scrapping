class PagesController < ApplicationController

  def home
    @classifieds = Classified.all
  end

  def about
  end

  def contact
  end

  def legal
  end

  def pricing
  end


end
