module PermissionHelper
  def is_admin?
    user_signed_in? && current_user.is_admin == true
  end
end
