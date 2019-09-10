require 'rails_helper'

RSpec.describe FullSimulation, type: :model do
  before(:each) do
    @full_simulation = create(:full_simulation)
    end



    context "validations" do

      it "is valid with valid attributes" do
          expect(@full_simulation).to be_a(FullSimulation)
          expect(@full_simulation).to be_valid
      end

    end

    context "associations" do

      describe "user" do
        it "belongs to one user" do
          expect(@full_simulation).to belong_to(:user)
        end
      end

      # describe "gas_simulation" do
      #   it "has one associated gas_simulation" do
      #     expect(@full_simulation).to have_one(:gas_simulation)
      #   end
      # end

    end

    context "callbacks" do

      describe "some callbacks" do
      end

    end

    context "public instance methods" do

      describe "#some_method" do
      end

    end

    context "public class methods" do

      describe "self.some_method" do
      end

    end

end
