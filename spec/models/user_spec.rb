require 'rails_helper'

RSpec.describe User, type: :model do
  before(:each) do
    @user = create(:user)
  end



  context 'validations' do

    it 'is valid with valid attributes' do
      expect(@user).to be_a(User)
      expect(@user).to be_valid
    end

    describe '#email' do
      it 'should not be valid without an email' do
        bad_user = create(:user_empty_email)
        expect(bad_user).not_to be_valid
        expect(bad_user.errors.include?(:email)).to eq(true)
      end
    end

  end

  context 'associations' do

    describe 'some association' do
      # teste cette association
    end

  end

  context 'callbacks' do

    describe 'some callbacks' do
      # teste ce callback
    end

  end

  context 'public instance methods' do

    describe '#some_method' do
      # teste cette méthode
    end

  end

  context 'public class methods' do

    describe 'self.some_method' do
      # teste cette méthode
    end

  end
end
