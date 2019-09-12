class ApplicationController < ActionController::Base
	before_action :set_cookie_user

	def after_sign_in_path_for(resource)
		if current_user.is_admin?
			stored_location_for(resource) || admin_root_path
		else
      stored_location_for(resource) || user_path(current_user)
    end
  end

private

	def set_cookie_user
		cookies[:username] = current_user.nil? ? "guest" : current_user.email
		
	end

  # def after_update_path_for(resource)
  #   stored_location_for(resource) || user_path(current_user)
  # end
end
