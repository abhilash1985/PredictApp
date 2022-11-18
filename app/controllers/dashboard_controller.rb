# frozen_string_literal: true

# DashboardController
class DashboardController < ApplicationController
  before_action :authenticate_user!, except: [:welcome, :change_my_password]
  skip_before_action :current_tournament
  layout 'login'

  def welcome
    @user = User.new
    @current_tournament = Tournament.first
    current_tournament_type
  end

  def index
    @tournaments = Tournament.all
  end

  def change_my_password
    @params = params.require(:user).permit(:email, :password, :password_confirmation)
    user = User.find_by(email: @params[:email])
    if user.nil?
      redirect_to new_user_password_path, notice: I18n.t('devise.failure.email_not_found')
    elsif @params[:password] == @params[:password_confirmation]
      update_password(user, @params)
    else
      redirect_to new_user_password_path, notice: I18n.t('devise.failure.password_not_match')
    end
  end

  private

  def update_password(user, params)
    if user.update(password: params[:password])
      redirect_to root_path, notice: I18n.t('devise.passwords.updated_not_active')
    else
      redirect_to new_user_password_path, notice: user.errors.full_messages.join(', ')
    end
  end
end
