require 'rails_helper'

RSpec.describe City, type: :model do
  before(:each) do
    @city = create(:city)
  end



  context 'validations' do

      it 'is valid with valid attributes' do
        expect(@city).to be_a(City)
        expect(@city).to be_valid
      end

      describe '#zip_code' do
        it 'can\'t be more than 5 numbers' do
          bad_zip = build(:city_bad_zip)
          expect(bad_zip).not_to be_valid
          expect(bad_zip.errors.include?(:zip_code)).to eq(true)
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
