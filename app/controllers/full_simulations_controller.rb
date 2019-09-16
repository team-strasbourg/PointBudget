# frozen_string_literal: true

class FullSimulationsController < ApplicationController
  before_action :user_signed_in?
  before_action :authenticate_user!
  before_action :not_other_users_full_simulations, except: [:index]

  def index
    @simulations = current_user.full_simulations
  end

  def show
    @full_simulation = FullSimulation.find(params[:id])
  end

  def new
    @full_simulation = FullSimulation.new
  end

  def create
    @full_simulation = FullSimulation.new(user: current_user)
    if @full_simulation.save
      respond_to do |format|
        format.html do
          flash[:success] = 'Vous venez de commencer une simulation'
          redirect_to user_full_simulation_path(current_user, @full_simulation)
        end

        format.js do
        end
      end
    else
      flash[:error] = @full_simulation.errors.messages
      render 'new'
    end
  end

  def edit
    @full_simulation = FullSimulation.find(params[:id])
  end

  def update
    @full_simulation = FullSimulation.find(params[:id])
    if @full_simulation.update(full_simulation_params)
      flash[:success] = 'Votre simulation a été validée'
      redirect_to user_full_simulation_path(current_user, @full_simulation)
    else
      flash[:error] = "Votre simulation n'a pas été validée"
      render :edit
    end
  end

  def destroy
    @full_simulation = FullSimulation.find(params[:id])
    @full_simulation.destroy
    respond_to do |format|
      format.html do
        flash[:success] = 'La simulation a bien été supprimée'
        redirect_to user_full_simulations_path(current_user)
      end
      format.js do
      end
    end
  end

  private

  def full_simulation_params
    params.require(:full_simulation).permit(:total_cost_saved, :validated, :counter)
  end
end
