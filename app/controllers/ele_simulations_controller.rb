# frozen_string_literal: true

class EleSimulationsController < ApplicationController
  before_action :authenticate_user!
  before_action :user_signed_in?
  before_action :not_other_users_ele_simulations, only: [:show]
  before_action :not_other_user_index, only:[:index]

   def show
    @ele_sim = EleSimulation.find(params[:id])
    @ele_contracts = @ele_sim.sort_contracts(3)
  end

  def new
    @full_simulation = FullSimulation.find(params[:full_simulation_id])
    if @full_simulation.only_one_ele_simulation
      flash[:error] = "Vous avez déjà comparé l'electricité dans cette simulation"
      redirect_to user_full_simulation_path(current_user, @full_simulation)
    else
      @ele_simulation = EleSimulation.new
    end
  end

  def create
    @full_simulation = FullSimulation.find(params[:full_simulation_id])
    @ele_simulation = EleSimulation.new
    @ele_simulation.assign_params_from_controller(params)

    comparison = @ele_simulation.comparison(params[:yearly_cost],params[:yearly_consumption],params[:kVA_power])
    @ele_simulation = EleSimulation.new(actual_price_paid: params[:yearly_cost],
                                        ele_cost_saved: comparison[0],
                                        ele_use: params[:yearly_consumption],
                                        full_simulation: @full_simulation)

    if @ele_simulation.save
      @ele_simulation.create_join_table_ele(comparison[1], comparison[2])
      @full_simulation.update(total_cost_saved: (@full_simulation.total_cost_saved + @ele_simulation.ele_cost_saved),
                              counter: @full_simulation.counter + 1)
      flash[:success] = "Votre simulation d'electricité a bien été enregistrée"
      redirect_to user_full_simulation_path(current_user, @full_simulation)
    else
      flash[:error] = @ele_simulation.errors.messages
      redirect_to new_user_full_simulation_ele_simulation_path(current_user, @full_simulation)
    end
  end
end
