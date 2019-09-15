# frozen_string_literal: true

class GasSimulationsController < ApplicationController
  before_action :authenticate_user!
  before_action :user_signed_in?
  before_action :not_other_users_simulations

  def index; end

  def show
    @gas_sim = GasSimulation.find(params[:id])
    table_attributes = @gas_sim.print_report
    @floor_space = table_attributes[0]
    @heat_type = table_attributes[1]
    @water_cooking_type = table_attributes[2]
    @residents_number = table_attributes[3]
  end

  def new
    @full_simulation = FullSimulation.find(params[:full_simulation_id])
    if @full_simulation.only_one_gas_simulation
      flash[:error] = 'Vous avez déjà comparé le gaz dans cette simulation'
      redirect_to user_full_simulation_path(current_user, @full_simulation)
    else
      @gas_simulation = GasSimulation.new
    end
  end

  def create
    @full_simulation = FullSimulation.find(params[:full_simulation_id])
    @gas_simulation = GasSimulation.new
    @gas_simulation.assign_params_from_controller(params)
    estimation = @gas_simulation.estimation(params[:yearly_cost],
                                            params[:yearly_consumption],
                                            params[:floor_space],
                                            params[:heat_type],
                                            params[:water_cooking_type],
                                            params[:nb_residents])
    comparison = estimation[0] == false ? [-1, false] : @gas_simulation.comparison(estimation[0], estimation[1])
    @gas_simulation = GasSimulation.new(actual_price_paid: params[:yearly_cost],
                                        gas_cost_saved: comparison[0],
                                        floor_space: params[:floor_space],
                                        heat_type: params[:heat_type],
                                        water_cooking_type: params[:water_cooking_type],
                                        residents_number: params[:nb_residents],
                                        gas_use: estimation[1],
                                        full_simulation: @full_simulation)

    if @gas_simulation.save
      @gas_simulation.create_join_table_gas(comparison[1])
      @full_simulation.update(total_cost_saved: (@full_simulation.total_cost_saved + @gas_simulation.gas_cost_saved),
                              counter: @full_simulation.counter + 1)
      flash[:success] = 'Votre simulation de gaz a bien été enregistrée'
      redirect_to user_full_simulation_path(current_user, @full_simulation)
    else
      flash[:error] = @gas_simulation.errors.messages
      redirect_to new_user_full_simulation_gas_simulation_path(current_user, @full_simulation)
    end
  end
end
