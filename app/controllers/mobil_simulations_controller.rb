class MobilSimulationsController < ApplicationController
  before_action :authenticate_user!
  before_action :user_signed_in?
  before_action :not_other_users_mobil_simulations, only: [:show]
  before_action :not_other_user_index, only: [:index]

  def show
    @mobil_simulation = MobilSimulation.find(params[:id])
    table_attributes = @mobil_simulation.print_report
    @tv = table_attributes[0]
    @call_fix_fr = table_attributes[1]
    @call_mob_fr = table_attributes[2]
    @box_contracts = @box_sim.sort_contracts(3)
  end

  def new
    @mobil_simulation = MobilSimulation.new
  end

  def create

    puts "#"*60
    puts params
    puts "#"*60

    @full_simulation = FullSimulation.find(params[:full_simulation_id])
    @mobil_simulation = MobilSimulation.new
    calls_europe = params[:calls_europe] == 'true' ? true : false
    calls_international = params[:calls_international] == 'true' ? true : false
    net_international = params[:net_international] == 'true' ? true : false

    comparison = @mobil_simulation.comparison(params[:monthly_cost], params[:bundle_go], calls_europe, calls_international, net_international)

    @mobil_simulation = MobilSimulation.new(actual_price_paid: params[:monthly_cost].to_f,
                                        mobil_cost_saved: comparison[0],
                                        calls_europe: calls_europe,
                                        calls_international:calls_international,
                                        net_international:net_international,
                                        bundle_go: params[:bundle_go].to_f,
                                        full_simulation: @full_simulation)
    if @mobil_simulation.save
      # create the join table with arguments the better contracts and the savings for each contracts
      @mobil_simulation.create_join_table_mobil(comparison[1], comparison[2])
      # update full_simulation
      @full_simulation.update(total_cost_saved: (@full_simulation.total_cost_saved + @mobil_simulation.mobil_cost_saved),
                              counter: @full_simulation.counter + 1)
    flash[:success] = 'Votre simulation de mobile a bien été enregistrée'
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
