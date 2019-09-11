class GasSimulationsController < ApplicationController
  def index

  end

  def show

  end

  def new
    @full_simulation = FullSimulation.find(params[:full_simulation_id])
    @gas_simulation = GasSimulation.new
  end

  def create
    @full_simulation = FullSimulation.find(params[:full_simulation_id])
    @gas_simulation = GasSimulation.new
    @gas_simulation.assign_params_from_controller(params)
    estimation = @gas_simulation.estimation
    comparison = @gas_simulation.comparison(estimation[0], estimation[1])
    @gas_simulation = GasSimulation.new(actual_price_paid: params[:yearly_cost],
                                        gas_cost_saved: comparison[0],
                                        floor_space: params[:floor_space],
                                        heat_type: params[:heat_type],
                                        water_cooking_type: params[:water_cooking_type],
                                        residents_number: params[:nb_residents],
                                        gas_use: estimation[1],
                                        full_simulation: @full_simulation
                                        )
    if @gas_simulation.save
      @gas_simulation.create_join_table_gas(comparison[1])
      @full_simulation.update(total_cost_saved: (@full_simulation.total_cost_saved + @gas_simulation.gas_cost_saved))
      redirect_to user_path(current_user)
    else
      flash[:error] = @gas_simulation.errors.messages
      render 'new'
    end
  end

  def destroy

  end

end
