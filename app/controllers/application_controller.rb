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
end
