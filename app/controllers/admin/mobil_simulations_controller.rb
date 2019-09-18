# frozen_string_literal: true

module Admin
  class MobilSimulationsController < ApplicationController
    def show
      @mobil_sim = MobilSimulation.find(params[:id])
      @user = @mobil_sim.user
      @mobil_contracts = @mobil_sim.sort_contracts(@mobil_sim.join_table_mobil_contracts.length)
    end
  end
end