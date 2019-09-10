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

  end

  context "associations" do

    describe "gas_simulation" do
      it "belongs to one full_simulation" do
        expect(@gas_simulation).to belong_to(:full_simulation)
      end
    end

  end

end
