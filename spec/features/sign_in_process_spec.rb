require 'rails_helper'
RSpec.describe 'the sign in process', type: :feature do
  before :each do
    User.create(email: 'user@example.com', password: 'password')
  end

  it 'signs me in' do
    visit '/users/new'

    within('#new_user') do
      fill_in 'Email', with: 'user@example.com'
      fill_in 'Password', with: 'password'
    end
    click_button 'Log in'
    expect(page).to have_content 'Mon Espace Client'
  end
end