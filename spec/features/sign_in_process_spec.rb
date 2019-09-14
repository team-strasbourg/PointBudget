require 'rails_helper'
RSpec.describe 'the sign in process', type: :feature do
  before :each do
    User.create(email: 'user@example.com', password: 'password')
  end

  scenario 'signs me in' do
    sign_in_with('user@example.com', 'password')
    expect(page).to have_content 'Mon Espace Client'
  end

  scenario 'with invalid email' do
    sign_in_with 'invalid_email', 'password'
    expect(page).to have_content('Log in')
  end

  scenario 'with blank password' do
    sign_in_with 'valid@example.com', ''
    expect(page).to have_content('Log in')
    end

  scenario 'with 4 letters password' do
    sign_in_with 'valid@example.com', 'azer'
    expect(page).to have_content('Log in')
  end

  def sign_in_with(email, password)
    visit new_user_session_path
    within('#new_user') do
      fill_in 'Email', with: email
      fill_in 'Password', with: password
      click_button 'Log in'
    end
  end
end