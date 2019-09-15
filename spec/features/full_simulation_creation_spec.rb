require 'rails_helper'
RSpec.describe 'Full Simulation', type: :feature do
  before :each do
    @user = User.create(email: 'user@example.com', password: 'password')
  end
  scenario 'create a new full simulation' do
    sign_in @user.email, @user.password
    visit new_user_full_simulation_path(@user)
    within('#body_content_user') do
      click_link 'Nouvelle Simulation'
    end
    expect(page).to have_content('Vous venez de commencer une simulation')
  end

  scenario 'validate a full simulation' do
    sign_in @user.email, @user.password
    visit new_user_full_simulation_path(@user)
    within('#body_content_user') do
      click_link 'Nouvelle Simulation'
    end
    click_button 'Résultat de ma simulation'
    expect(page).to have_content('D\'après nos comparateurs, vous pourriez économiser')
    click_button 'Valider ma simulation'
    expect(page).to have_content('Votre simulation a été validée')
  end


end