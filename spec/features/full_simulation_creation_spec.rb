# frozen_string_literal: true

require 'rails_helper'
RSpec.describe 'Full Simulation creation', type: :feature do
  before :each do
    @user = User.create(email: 'user@example.com', password: 'password')
    sign_in @user.email, @user.password
  end
  scenario 'create a new full simulation' do
    visit new_user_full_simulation_path(@user)
    within('#body_content_user') do
      click_link 'Je lance ma simulation'
    end
    expect(page).to have_content('Vous venez de commencer une simulation')
  end

  scenario 'validate a full simulation' do
    visit new_user_full_simulation_path(@user)
    within('#body_content_user') do
      click_link 'Je lance ma simulation'
    end
    click_button 'Je finalise ma simulation'
    expect(page).to have_content('D\'après nos comparateurs, vous pourriez économiser')
    click_button 'Valider ma simulation'
    expect(page).to have_content('Votre simulation a été validée')
  end

  scenario 'add in index non validated' do
    visit new_user_full_simulation_path(@user)
    within('#body_content_user') do
      click_link 'Je lance ma simulation'
    end
    visit user_full_simulations_path(@user)
    within('#table-validated') do
      expect(page).not_to have_content(FullSimulation.last.id)
    end
    within('#table-non-validated') do
      expect(page).to have_content(FullSimulation.last.id)
    end
  end
end
