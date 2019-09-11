class EnergiesController < ApplicationController

  def new
    @full_simulation = FullSimulation.find(params[:full_simulation_id])
  end
  def show
  end
  
end
