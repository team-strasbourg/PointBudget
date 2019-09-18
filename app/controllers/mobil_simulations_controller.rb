class MobilSimulationsController < ApplicationController
  before_action :authenticate_user!
  before_action :user_signed_in?
  before_action :not_other_users_mobil_simulations, only: [:show]
  before_action :not_other_user_index, only: [:index]

  def show
    @mobil_simulation = MobilSimulation.find(params[:id])
  end

  def new
    @mobil_simulation = MobilSimulation.new
  end

  def create
    @full_simulation = FullSimulation.find(params[:full_simulation_id])
    @mobil_simulation = MobilSimulation.new

    if @mobil_simulation.save
      flash[:success] = "Votre simulation concernant votre mobile a été sauvegardée!"
    else
      flash[:error] = @mobil_simulation.errors.messages
    end
    redirect_to user_full_simulation_path(current_user, @full_simulation)
  end

  def edit
  end

  def update
  end

  def destroy
  end
end
