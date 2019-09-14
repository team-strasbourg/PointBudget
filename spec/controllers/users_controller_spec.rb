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
    login_user
    it "assigns @users" do
      get :edit, params: { id: subject.current_user.id }
      expect(assigns(:user)).to eq(subject.current_user)
    end

    it "renders the edit template" do
      get :edit, params: { id: subject.current_user.id }
      expect(response).to render_template("edit")
    end
  end

  describe "PUT update" do
    login_user

    context "with valid attributes" do
      it "located the requested @user" do
        put :update,  params: { id: subject.current_user.id, user:{ email: Faker::Internet.email, password: Faker::Internet.password, city_id: '' } }
        expect(assigns(:user)).to eq(subject.current_user)
      end

      it "changes @user's attributes" do
        email = Faker::Internet.email
        password = Faker::Internet.password
        put :update,  params: { id: subject.current_user, "user" => { email: email, password: password } }
        subject.current_user.reload
        subject.current_user.firstname.should eq(email)
        subject.current_user.lastname.should eq(password)
      end
      #
      # it "redirects to the updated contact" do
      #   put :update, id: @user, params: { "user" => { email: Faker::Internet.email, password: Faker::Internet.password } }
      #
      #   # redirige où tu veux
      #   response.should redirect_to @user
      # end
    end

    # context "with invalid attributes" do
    #   it "locates the requested @user" do
    #     put :update, id: @user, params: { "user" => { invalide_magueule } }
    #     assigns(:user).should eq(@user)
    #   end
    #
    #   it "does not change @user's attributes" do
    #     put :update, id: @user, params: { "user" => { invalide_magueule } }
    #     @user.reload
    #     @user.firstname.should_not eq("Jean")
    #     @user.lastname.should eq("Bon")
    #   end
    #
    #   it "re-renders the edit method" do
    #     put :update, id: @user, params: { "user" => { invalide_magueule } }
    #     response.should render_template :edit
    #   end
    # end
  end
end
