require 'rails_helper'

RSpec.describe "users/edit.html.erb", type: :view do
  before :each do
    @user = create(:user)
    3.times do
      create(:city)
    end
    @cities = City.all
  end
  it "displays 'Editer mon Profile'" do
    sign_in @user
    render
    expect(rendered).to have_content 'Editer mon profil'
  end
  it "displays the name" do
    sign_in @user
    render
    expect(rendered).to have_content 'Votre prénom'
    expect(rendered).to have_content 'Votre nom'
  end

  it "displays the phone number" do
    sign_in @user
    render
    expect(rendered).to have_content 'Votre numéro de téléphone'
  end

  it "displays the city field" do
    sign_in @user
    render
    expect(rendered).to have_content 'Votre ville'
  end

end
