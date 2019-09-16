# frozen_string_literal: true

class ApplicationController < ActionController::Base
  before_action :set_cookie_user
  rescue_from ActiveRecord::RecordNotFound, with: :render_404
  rescue_from ActionController::RoutingError, with: :render_404

  def after_sign_in_path_for(resource)
    if current_user.is_admin?
      stored_location_for(resource) || admin_root_path
    else
      stored_location_for(resource) || user_path(current_user)
    end
  end

  def not_found
    raise ActionController::RoutingError, 'Not Found'
  rescue
    render_404
  end

  private

  def render_404
    render file: "#{Rails.root}/public/404", status: :not_found
  end

  def set_cookie_user
    cookies[:username] = current_user.nil? ? 'guest' : current_user.email
  end

  def not_other_user
    # This method prevents users from going to another user's show and edit pages
    return unless current_user != User.find(params[:id])

    flash[:error] = "Vous n'avez pas le droit d'accéder à cette page"
    redirect_to user_path(current_user)
  end

  def not_other_users_full_simulations
    # This method prevents users from going to pages associated with another user, namely the simulations
    return unless current_user != FullSimulation.find(params[:id]).user

    flash[:error] = "Vous n'avez pas le droit d'accéder à cette page"
    redirect_to user_path(current_user)
  end

  def not_other_users_gas_simulations
    # This method prevents users from going to pages associated with another user, namely the simulations
    return unless current_user != GasSimulation.find(params[:id]).full_simulation.user && FullSimulation.find(params[:full_simulation_id]) == GasSimulation.find(params[:id]).full_simulation

    flash[:error] = "Vous n'avez pas le droit d'accéder à cette page"
    redirect_to user_path(current_user)
  end
end
