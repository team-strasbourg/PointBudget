# frozen_string_literal: true

require 'rails_helper'
RSpec.describe 'Full Simulation', type: :feature do
  before :each do
    @user = User.create(email: 'user@example.com', password: 'password')
  end
  scenario 'create a new full simulation' do
    sign_in @user.email, @user.password
    visit new_user_full_simulation_path(@user)
    within('#body_content_user') do
      click_link 'Lancer ma simulation'
    end
    expect(page).to have_content('Vous venez de commencer une simulation')
  end

  scenario 'validate a full simulation' do
    sign_in @user.email, @user.password
    visit new_user_full_simulation_path(@user)
    within('#body_content_user') do
      click_link 'Lancer ma simulation'
    end
    click_button 'Je finalise ma simulation'
    expect(page).to have_content('D\'après nos comparateurs, vous pourriez économiser')
    click_button 'Valider ma simulation'
    expect(page).to have_content('Votre simulation a été validée')
  end

  scenario 'add in index non validated' do
    sign_in @user.email, @user.password
    visit new_user_full_simulation_path(@user)
    within('#body_content_user') do
      click_link 'Lancer ma simulation'
    end
    visit user_full_simulations_path(@user)
    expect(page).to have_content(FullSimulation.last.id)

  end
end
