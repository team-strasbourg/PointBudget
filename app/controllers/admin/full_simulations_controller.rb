# frozen_string_literal: true

module Admin
  class FullSimulationsController < ApplicationController


    def show
      @full_simulation = FullSimulation.find(params[:id])
      @gas_simulation = GasSimulation.new
      @box_simulation = BoxSimulation.new
      @ele_simulation = EleSimulation.new
    end
  end
end