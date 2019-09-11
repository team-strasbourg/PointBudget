require 'rails_helper'

RSpec.describe GasSimulation, type: :model do
  before(:each) do
    @gas_simulation = create(:gas_simulation)
    end

  context "validations" do

    it "is valid with valid attributes" do
        expect(@gas_simulation).to be_a(GasSimulation)
        expect(@gas_simulation).to be_valid
    end

    describe "#actual_price_paid" do
      it 'should have an actual paid price' do
        expect(build(:gas_empty_price_paid)).not_to be_valid
      end

      it 'should be positive' do
        expect(build(:gas_simulation, actual_price_paid: -1)).not_to be_valid
      end
    end

    describe "#gas_cost_saved" do
      it 'should have an gas_cost_saved' do
        expect(build(:gas_empty_cost_saved)).not_to be_valid
      end

      it 'can be 0' do
        expect(build(:gas_zero_cost_saved)).to be_valid
      end

      it 'should be positive' do
        expect(build(:gas_simulation, actual_price_paid: -1)).not_to be_valid
      end
    end

    describe'#floor_space' do
      it 'can be empty' do
        expect(build(:gas_simulation, floor_space: nil)).to be_valid
      end

      it 'can not be under 9' do
        expect(build(:gas_simulation, floor_space: 8)).not_to be_valid
        expect(build(:gas_simulation, floor_space: 9)).to be_valid
      end
    end

    describe '#heat_type' do
      it 'can be blank' do
        expect(build(:gas_simulation, heat_type: nil)).to be_valid
      end
      it 'can be either Gaz or Electricite' do
        expect(build(:gas_simulation)).to be_valid
        expect(build(:gas_simulation, heat_type: 'other')).not_to be_valid
      end
    end

    describe '#water_cooking_type' do
      it 'can be blank' do
        expect(build(:gas_simulation, water_cooking_type: nil)).to be_valid
      end
      it 'can be either Gaz or Electricite' do
        expect(build(:gas_simulation)).to be_valid
        expect(build(:gas_simulation, water_cooking_type: 'other')).not_to be_valid
      end
    end

    describe "#residents_number" do
      it 'can be blank' do
        expect(build(:gas_simulation, residents_number: nil)).to be_valid
      end

      it 'should be greater than 1 ' do
        expect(build(:gas_simulation, residents_number: -1)).not_to be_valid
        expect(build(:gas_simulation, residents_number: 0)).not_to be_valid
      end
    end

    describe '#gas_use' do
      it 'should not be blank' do
        expect(build(:gas_simulation, gas_use: nil)).not_to be_valid
      end

      it 'should be greater than 0' do
        expect(build(:gas_simulation, gas_use: -1)).not_to be_valid
      end

      it 'should be an integer' do
        expect(build(:gas_simulation, gas_use: 1.02)).not_to be_valid
      end
    end
  end

  context "associations" do

    describe "gas_simulation" do
      it "belongs to one full_simulation" do
        expect(@gas_simulation).to belong_to(:full_simulation)
      end
    end

  end

end
