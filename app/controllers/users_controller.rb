class UsersController < ApplicationController
	before_action :authenticate_user!
  skip_before_action :verify_authenticity_token
  attr_accessor :current_ville_id

  def dashboard
    @resorts = Resort.all

    #Inscription
    s = Subscription.new
    s.user = current_user
    if params["ville"]
      s.resort = Resort.find_by_ville(params["ville"].downcase)
    end
    if s.resort
      @current_ville_id = s.resort.id
    end

    if Subscription.where(user_id:current_user.id).where(resort_id:@current_ville_id) == []
      s.save
    else
      flash.now[:alert] = "Vous êtes déjà abonné(e) à cette station!"  
    end

    @classifieds_hash = {}
    @subscriptions = Subscription.where(user_id:current_user.id)
    @subscriptions.each do |s|
      @classifieds_hash[Resort.find(s.resort_id).ville] = Classified.where(resort_id:s.resort_id)
    end
    

    # @classifieds = Classified.all
    @averages = Classified.group("ville").group("start_date").group("number_of_guests").average("price")
    @number_of_guests = params[:number_of_guests]
  end
  
end
