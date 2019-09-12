require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  describe 'GET show' do


    it "should have a current_user" do
      login_user
      expect(subject.current_user).to_not eq(nil)
    end


    it 'renders the show template' do
      login_user
      get :show
      expect(response).to render_template('show')
    end
  end

end
