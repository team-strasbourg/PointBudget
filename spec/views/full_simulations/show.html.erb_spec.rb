# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'full_simulations/show.html.erb', type: :view do
  context 'Non validated' do
    before :each do
      @user = create(:user)
      sign_in @user
      @full_simulation = create(:full_simulation, user: @user)
      render
    end
    it "displays 'Mon Profile'" do
      expect(rendered).to have_content 'Vous désirez economiser un maximum?'
    end

    it "displays 'Mon Profile'" do
      expect(rendered).to have_content 'Je finalise ma simulation'
    end
  end

  context 'Validated' do
    before :each do
      @user = create(:user)
      sign_in @user
      @full_simulation = create(:full_simulation, user: @user, validated: true)
      render
    end
    it "displays 'Mon Profile'" do
      expect(rendered).to have_content 'Vous venez de valider votre simulation'
    end

    it "displays 'Mon Profile'" do
      expect(rendered).to have_content 'Regardons de près:'
    end
  end
end
