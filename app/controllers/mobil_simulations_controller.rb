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

    puts "#"*60
    puts params
    puts "#"*60

    @full_simulation = FullSimulation.find(params[:full_simulation_id])
    @mobil_simulation = MobilSimulation.new
    calls_europe = params[:calls_europe] == 'true' ? true : false
    calls_international = params[:calls_international] == 'true' ? true : false
    net_international = params[:net_international] == 'true' ? true : false

    #comparison
    comparison = @mobil_simulation.comparison(params[:monthly_cost], params[:bundle_go], calls_europe, calls_international, net_international)

    @mobil_simulation = MobilSimulation.new(actual_price_paid: params[:monthly_cost],
                                        box_cost_saved: comparison[0],
                                        tv: tv,
                                        call_fix_fr:call_fix_fr,
                                        call_mob_fr:call_mob_fr,
                                        full_simulation: @full_simulation)

    # if @mobil_simulation.save
    #   flash[:success] = "Votre simulation concernant votre mobile a été sauvegardée!"
    # else
    #   flash[:error] = @mobil_simulation.errors.messages
    # end
    # redirect_to user_full_simulation_path(current_user, @full_simulation)
  end

  def edit
  end

  def update
  end

  def destroy
  end
end
