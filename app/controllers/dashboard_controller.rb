class DashboardController < ApplicationController
	before_filter :authenticate_user!, except:[:welcome]
	skip_before_filter :require_no_authentication, only:[:welcome]

  def welcome
  	@user = User.new
  end

  def index
  	
  end
  
end
