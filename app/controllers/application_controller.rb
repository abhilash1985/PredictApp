# ApplicationController
class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  # protect_from_forgery with: :exception
  before_action :store_user_location!, if: :storable_location?

  before_action :configure_permitted_parameters, if: :devise_controller?
  # before_filter :authenticate_user!
  before_action :current_tournament

  def after_sign_in_path_for(resource)
    stored_location_for(resource) || dashboard_index_path
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

  private

  # Its important that the location is NOT stored if:
  # - The request method is not GET (non idempotent)
  # - The request is handled by a Devise controller such as Devise::SessionsController as that could cause an
  #    infinite redirect loop.
  # - The request is an Ajax request as this can lead to very unexpected behaviour.
  def storable_location?
    request.get? && is_navigational_format? && !devise_controller? &&
      !request.xhr? && request.path != '/users/sign_in' &&
      request.path != '/users/sign_up' &&
      request.path != '/users/password/new' &&
      request.path != '/users/password/edit' &&
      request.path != '/users/confirmation' &&
      request.path != '/users/sign_out' &&
      !request.xhr?
  end

  def store_user_location!
    # :user is the scope we are authenticating
    store_location_for(:user, request.fullpath)
  end
end
