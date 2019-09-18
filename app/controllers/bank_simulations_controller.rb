# frozen_string_literal: true

class BankSimulationsController < ApplicationController
  before_action :authenticate_user!
  before_action :user_signed_in?
  before_action :not_other_users_bank_simulations, only: [:show]
  before_action :not_other_user_index, only: [:index]

  def show
    @bank_sim = BankSimulation.find(params[:id])
    table_attributes = @bank_sim.print_report
    @tv = table_attributes[0]
    @call_fix_fr = table_attributes[1]
    @call_mob_fr = table_attributes[2]
    @bank_contracts = @bank_sim.sort_contracts(3)
  end

  def new
    @full_simulation = FullSimulation.find(params[:full_simulation_id])
    if @full_simulation.only_one_bank_simulation
      flash[:error] = 'Vous avez déjà comparé la banque dans cette simulation'
      redirect_to user_full_simulation_path(current_user, @full_simulation)
    else
      @bank_simulation = BankSimulation.new
    end
  end

  def create
    @full_simulation = FullSimulation.find(params[:full_simulation_id])
    @bank_simulation = BankSimulation.new
    my_params = params[:bank_simulation]
    # tv = my_params[:tv] == 'true' ? true : false
    # call_fix_fr = my_params[:call_fix_fr] == 'true' ? true : false
    # call_mob_fr = my_params[:call_mob_fr] == 'true' ? true : false
    # comparison = @bank_simulation.comparison(params[:monthly_cost], tv, call_fix_fr, call_mob_fr)
    # @bank_simulation = BankSimulation.new(actual_price_paid: params[:monthly_cost],
    #                                     bank_cost_saved: comparison[0],
    #                                     tv: tv,
    #                                     call_fix_fr:call_fix_fr,
    #                                     call_mob_fr:call_mob_fr,
    #                                     full_simulation: @full_simulation)
    #
    # if @bank_simulation.save
    #   @bank_simulation.create_join_table_bank(comparison[1], comparison[2])
    #   @full_simulation.update(total_cost_saved: (@full_simulation.total_cost_saved + @bank_simulation.bank_cost_saved),
    #                           counter: @full_simulation.counter + 1)
    #   flash[:success] = 'Votre simulation de gaz a bien été enregistrée'
    # else
    #   flash[:error] = "Veuillez remplir tous les champs pour terminer la simulation d'offre internet"
    # end
    # redirect_to user_full_simulation_path(current_user, @full_simulation)
  end
end
