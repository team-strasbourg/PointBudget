# frozen_string_literal: true

require 'rails_helper'

RSpec.describe FullSimulationsController, type: :controller do
  login_user
  describe 'GET show' do
    before :each do
      2.times do
        create(:full_simulation, user: subject.current_user)
      end
    end
    it 'should have a current_user' do
      expect(subject.current_user).to_not eq(nil)
    end

    it 'renders the show template' do
      get :show, params: { user_id: subject.current_user.id, id: subject.current_user.full_simulations.all.sample }
      expect(response).to have_http_status(:success)
    end

    it 'redirect to his root page if try to see another full simulation' do
      user = create(:user)
      simu = create(:full_simulation, user: user)
      get :show, params: { user_id: subject.current_user.id, id: simu.id }
      expect(response).to redirect_to("/users/#{subject.current_user.id}/full_simulations/new")
    end
  end

  describe "GET index" do
    it "assigns a full simulation" do
      simu = create(:full_simulation, user: subject.current_user)
      get :index, params: { user_id: subject.current_user.id }
      expect(assigns(:simulations)).to eq([simu])
    end

    it "renders the index template" do
      get :index, params: { user_id: subject.current_user.id }
      expect(response).to render_template("index")
    end
  end

  describe "GET new" do
    it "renders the new template" do
      get :new, params: { user_id: subject.current_user.id }
      expect(response).to render_template("new")
    end
  end
end
