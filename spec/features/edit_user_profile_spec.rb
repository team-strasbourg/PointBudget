# frozen_string_literal: true

require 'rails_helper'
RSpec.describe 'Edit User Profile', type: :feature do
  before :each do
    @user = User.create(email: 'user@example.com', password: 'password')
    sign_in @user.email, @user.password
  end

  scenario 'can edit his profile with correct things' do

  end
end