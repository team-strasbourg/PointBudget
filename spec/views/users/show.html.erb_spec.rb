require 'rails_helper'

RSpec.describe "users/show.html.erb", type: :view do
  context 'it says Mon Profile' do
    it "displays 'Mon Profile'" do
      render
      expect(rendered).to have_content 'My Profile'
    end
  end
end
