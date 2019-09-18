# frozen_string_literal: true

module Admin
  class FullSimulationsController < ApplicationController

    def show
      @user = User.find(params{:user_id})
      @full_simulation = FullSimulation.find(params[:id])
    end
  end
end