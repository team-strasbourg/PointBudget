module Admin
  class ApplicationController < ::ActionController

    before_action :only_admin

    private

    def only_admin
      unless user_signed_in? && current_user.is_admin == true
        flash[:danger] = 'You\'re not allowed on this page'
        redirect_to items_path
      end
    end
  end
end