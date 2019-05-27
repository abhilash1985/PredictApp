# ApplicationController
class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  # protect_from_forgery with: :exception

  before_action :configure_permitted_parameters, if: :devise_controller?
  # before_filter :authenticate_user!
  before_action :current_tournament

  def after_sign_in_path_for(_resource)
    dashboard_index_path
  end

  def current_tournament
    return unless user_signed_in?
    session[:tournament_id] = params[:id] unless params[:id].blank?
    @current_tournament ||= Tournament.find_by_id(session[:tournament_id])
    # @current_tournament ||= Tournament.active.first
    # @current_tournament ||= Tournament.first
    current_tournament_type
  end

  protected

  def current_tournament_type
    return unless @current_tournament
    @current_tournament_name ||= @current_tournament.tournament_type.name
    @current_tournament_type ||= @current_tournament.tournament_type.game
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:first_name, :middle_name, :last_name])
  end
end
