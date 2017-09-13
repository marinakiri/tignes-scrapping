class UsersController < ApplicationController
	# before_action :authenticate_user!

  def dashboard
    @resorts = Resort.all
  end
  
end
