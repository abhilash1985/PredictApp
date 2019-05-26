# DashboardController
class DashboardController < ApplicationController
  before_action :authenticate_user!, except: [:welcome]
  skip_before_action :current_tournament
  layout 'login'

  def welcome
    @user = User.new
  end

  def index
    @tournaments = Tournament.all
  end
end
