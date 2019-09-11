class GasSimulationsController < ApplicationController

  def index

  end

  def show

  end

  def new
    @gas_simulation = GasSimulation.new
  end

  def create
    50.times do
      puts "#"
    end
  end

  def destroy

  end

end
