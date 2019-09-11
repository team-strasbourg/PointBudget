class ApplicationController < ActionController::Base
	def after_sign_in_path_for(resource)
		super
		if current_user.is_admin?
			stored_location_for(resource) || admin_root_path
		else
      stored_location_for(resource) || user_path(current_user)
    end
  end
end
