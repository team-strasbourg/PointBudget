require 'rails_helper'

RSpec.describe GazContract, type: :model do
  before(:each) do
    @gas_contract = create(:gas_contract)
  end

  context 'validations' do

    it 'is valid with valid attributes' do
      expect(@gas_contract).to be_a(GasContract)
      expect(@gas_contract).to be_valid
    end

    describe '#kw_consumption_per_year' do
      it 'should not be valid with a to high valid kw_consumption email' do
        bad_gas_contract = build(:gas_contract_more_year_consumption)
        expect(bad_gas_contract).not_to be_valid
        expect(bad_gas_contract.errors.include?(:kw_consumption_per_year)).to eq(true)
      end

      it 'should not be valid with a to low valid kw_consumption email' do
        bad_gas_contract = build(:gas_contract_less_year_consumption)
        expect(bad_gas_contract).not_to be_valid
        expect(bad_gas_contract.errors.include?(:kw_consumption_per_year)).to eq(true)
      end
    end

    describe '#password' do
      it 'should not be valid without a password' do
        bad@gas_contract = build(@gas_contract_empty_password)
        expect(bad@gas_contract).not_to be_valid
        expect(bad@gas_contract.errors.include?(:password)).to eq(true)
      end

      it 'should not be valid with a bad password' do
        bad@gas_contract = build(@gas_contract_bad_password)
        expect(bad@gas_contract).not_to be_valid
        expect(bad@gas_contract.errors.include?(:password)).to eq(true)
      end
    end

    describe '#phone_number' do
      it 'can be blank' do
       @gas_contract = build(@gas_contract_empty_phone)
        expect@gas_contract).to be_valid
      end
      it 'should be a valid french number' do
        expect(@gas_contract.phone_number).to match /^((\+)33|0)[1-9](\d{2}){4}$/
      end
    end

  end

  context 'associations' do

    describe 'city association' do
      it 'should belongs_to a city' do
        expect(@gas_contract).to belong_to(:city)
      end
    end

    describe 'full_simulations association' do
      it 'should have many full_simulations' do
        expect(@gas_contract).to have_many(:full_simulations)
      end
    end

  end

  context 'callbacks' do

    describe 'some callbacks' do
    end

  end

  context 'public instance methods' do

    describe '#some_method' do
    end

  end

  context 'public class methods' do

    describe 'self.some_method' do
    end

  end
end
