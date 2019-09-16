# frozen_string_literal: true

class BoxSimulationsController < ApplicationController
  before_action :authenticate_user!
  before_action :user_signed_in?
  before_action :not_other_users_gas_simulations, only: [:show]
  before_action :not_other_user_index, only: [:index]

  def index; end

  def show
    @box_sim = BoxSimulation.find(params[:id])
    table_attributes = @box_sim.print_report
    @tv = table_attributes[0]
    @call_fix_fr = table_attributes[1]
    @call_mob_fr = table_attributes[2]
  end

  def new
    @full_simulation = FullSimulation.find(params[:full_simulation_id])
    if @full_simulation.only_one_box_simulation
      flash[:error] = 'Vous avez déjà comparé le gaz dans cette simulation'
      redirect_to user_full_simulation_path(current_user, @full_simulation)
    else
      @box_simulation = BoxSimulation.new
    end
  end

  def create
    @full_simulation = FullSimulation.find(params[:full_simulation_id])
    @box_simulation = BoxSimulation.new
    @box_simulation.assign_params_from_controller(params)
    estimation = @box_simulation.estimation(params[:yearly_cost],
                                            params[:yearly_consumption],
                                            params[:floor_space],
                                            params[:heat_type],
                                            params[:water_cooking_type],
                                            params[:nb_residents])
    comparison = estimation[0] == false ? [-1, false] : @box_simulation.comparison(estimation[0], estimation[1])
    @box_simulation = BoxSimulation.new(actual_price_paid: params[:yearly_cost],
                                        box_cost_saved: comparison[0],
                                        floor_space: params[:floor_space],
                                        heat_type: params[:heat_type],
                                        water_cooking_type: params[:water_cooking_type],
                                        residents_number: params[:nb_residents],
                                        box_use: estimation[1],
                                        full_simulation: @full_simulation)

    if @box_simulation.save
      @box_simulation.create_join_table_box(comparison[1], comparison[2])
      @full_simulation.update(total_cost_saved: (@full_simulation.total_cost_saved + @box_simulation.box_cost_saved),
                              counter: @full_simulation.counter + 1)
      flash[:success] = 'Votre simulation de gaz a bien été enregistrée'
    else
      flash[:error] = @box_simulation.errors.messages
    end
    redirect_to user_full_simulation_path(current_user, @full_simulation)
  end
end
