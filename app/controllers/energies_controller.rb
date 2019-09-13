class EnergiesController < ApplicationController
  before_action :authenticate_user!
  before_action :not_other_users_simulations

  def new
    @full_simulation = FullSimulation.find(params[:full_simulation_id])
  end
  def show
  end
  
end
