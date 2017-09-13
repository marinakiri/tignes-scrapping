class UsersController < ApplicationController
	# before_action :authenticate_user!

  def dashboard
    @resorts = Resort.all
    s = Subscription.new
    s.user = current_user
    s.resort = Resort.find_by_ville(params["ville"])
    s.save
    @subscriptions = Subscription.all
  end
  
end
