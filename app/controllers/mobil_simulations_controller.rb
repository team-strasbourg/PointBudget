class MobilSimulationsController < ApplicationController
  before_action :authenticate_user!
  before_action :user_signed_in?

  def index; end

  def show
    @mobil_simulation = MobilSimulation.find(params[:id])
  end

  def new
    @mobil_simulation = MobilSimulation.new
  end

  def create
    @mobil_simution = MobilSimulation.find(params[:id])
  end

  def edit
  end

  def update
  end

  def destroy
  end
end
