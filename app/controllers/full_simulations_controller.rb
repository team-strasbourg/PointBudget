class FullSimulationsController < ApplicationController

  def index
    @full_simulations = FullSimulation.all
  end

  def show
  end

  def new
    @full_simulation = FullSimulation.new
  end

  def create
    @full_simulation = FullSimulation.new
    if @full_simulation.save
      flash[:success] = "Vous venez de commencer une simulation"
      redirect_to 
    else
      render :new
    end
  end

  def edit
    @full_simulation = FullSimulation.find(params[:id])
  end

  def update
    @full_simulation = FullSimulation.find(params[:id])
    if @full_simulation.update
      flash[:success] = "Votre simulation a été validée"
      redirect_to user_path(current_user)
    else
      flash[:error] = "Votre simulation n'a été validée"
      render :edit
  end

  def destroy
  end
end
