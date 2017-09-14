class SubscriptionsController < ApplicationController
 
  def destroy
    Subscription.find(params[:id]).destroy
    redirect_to '/dashboard'
  end

end
