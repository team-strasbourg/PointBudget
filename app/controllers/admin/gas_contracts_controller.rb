module Admin
  class GasContractsController < ApplicationController

    def index
      @contracts = GasContract.all
    end

    def new
      @contract = GasContract.new
    end

    def create
      my_params=params[:gas_contract]
      @contract = GasContract.new(
          supplier: my_params[:supplier],
          offer_name: my_params[:offer_name],
          subscription_base_price_month: my_params[:subscription_base_price_month],
          kwh_price_base: my_params[:kwh_price_base],
          low_kw_consumption_per_year: my_params[:low_kw_consumption_per_year],
          high_kw_consumption_per_year: my_params[:high_kw_consumption_per_year]
      )
      if @contract.save
        flash[:success]='Contract created'
        redirect_to admin_root_path
      else
        render 'new'
      end
    end

  end
end