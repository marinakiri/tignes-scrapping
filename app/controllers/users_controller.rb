class UsersController < ApplicationController
	before_action :authenticate_user!
  attr_accessor :current_ville_id

  def dashboard
    @resorts = Resort.all

    #Inscription
    s = Subscription.new
    s.user = current_user
    s.resort = Resort.find_by_ville(params["ville"])
    if s.resort
      @current_ville_id = s.resort.id
    end

    if Subscription.where(user_id:current_user.id).where(resort_id:@current_ville_id) == []
      s.save
    else
      flash.now[:alert] = "Vous êtes déjà abonné(e) à cette station!"  
    end

    @subscriptions = Subscription.all
    @classifieds = Classified.all
    @averages = Classified.group("ville").group("start_date").group("number_of_guests").average("price")
    @number_of_guests = params[:number_of_guests]
  end
  
end
