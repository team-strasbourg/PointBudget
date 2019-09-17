# frozen_string_literal: true

class BoxSimulationsController < ApplicationController
  before_action :authenticate_user!
  before_action :user_signed_in?
  before_action :not_other_users_box_simulations, only: [:show]
  before_action :not_other_user_index, only: [:index]

  def index; end

  def show
    @box_sim = BoxSimulation.find(params[:id])
    table_attributes = @box_sim.print_report
    @tv = table_attributes[0]
    @call_fix_fr = table_attributes[1]
    @call_mob_fr = table_attributes[2]
    @box_contracts = @box_sim.sort_contracts(3)
  end

  def new
    @full_simulation = FullSimulation.find(params[:full_simulation_id])
    if @full_simulation.only_one_box_simulation
      flash[:error] = 'Vous avez déjà comparé la box dans cette simulation'
      redirect_to user_full_simulation_path(current_user, @full_simulation)
    else
      @box_simulation = BoxSimulation.new
    end
  end

  def create
    @full_simulation = FullSimulation.find(params[:full_simulation_id])
    @box_simulation = BoxSimulation.new
    @box_simulation.assign_params_from_controller(params)
    my_params = params[:box_simulation]
    tv = my_params[:tv] == 'true' ? true : false
    call_fix_fr = my_params[:call_fix_fr] == 'true' ? true : false
    call_mob_fr = my_params[:call_mob_fr] == 'true' ? true : false
    @box_simulation.assign_params_from_controller(params)
    comparison = @box_simulation.comparison(params[:monthly_cost], tv, call_fix_fr, call_mob_fr)
    @box_simulation = BoxSimulation.new(actual_price_paid: params[:monthly_cost],
                                        box_cost_saved: comparison[0],
                                        tv: tv,
                                        call_fix_fr:call_fix_fr,
                                        call_mob_fr:call_mob_fr,
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
