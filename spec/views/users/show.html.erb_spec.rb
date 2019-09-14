require 'rails_helper'

RSpec.describe "users/show.html.erb", type: :view do

  before :each do
    @user = create(:user)
  end
  it "displays 'Mon Profile'" do
    sign_in @user
    render
    expect(rendered).to have_content 'Mon Profil'
  end

  it "displays the mail" do
    sign_in @user
    render
    expect(rendered).to have_content @user.email
  end

  it "displays have link to edition" do
    sign_in @user
    render
    expect(rendered).to have_content 'Editer mon profil'
    expect(rendered).to have_content 'Editer mon compte'
  end
end
