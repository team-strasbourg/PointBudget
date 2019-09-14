require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  describe 'GET show' do
    login_user

    it 'should have a current_user' do
      expect(subject.current_user).to_not eq(nil)
    end

    it 'renders the show template' do
      get :show, params: { id: subject.current_user.id }
      expect(response).to have_http_status(:success)
    end

    it 'redirect to his profile if try to see another user' do
      create(:user)
      get :show, params: { id: (subject.current_user.id.to_i + 1) }
      expect( response ).to redirect_to("/users/#{subject.current_user.id}" )
    end
  end

  describe "anonymous user show" do

    it "should be redirected to signin" do
      get :show
      expect( response ).to redirect_to( new_user_session_path )
    end
  end

  describe "GET edit" do
    it "assigns @users" do
      get :edit, params: { id: subject.current_user.id }
      expect(assigns(:user)).to eq(subject.current_user)
    end

    it "renders the edit template" do
      get :edit, params: { id: subject.current_user.id }
      expect(response).to render_template("edit")
    end
  end
end
