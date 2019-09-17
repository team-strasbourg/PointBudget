class MobilSimulationsController < ApplicationController
  before_action :authenticate_user!
  before_action :user_signed_in?

  def index; end

  def show
    @mobil_simu = MobilSimulation.find(params[:id])
  end

  def new
    @mobil_simu = MobilSimulation.new
  end

  def create
    @mobil_simu = MobilSimulation.find(params[:id])
  end

  def edit
  end

  def update
  end

  def destroy
  end
end
