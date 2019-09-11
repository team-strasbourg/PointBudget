module Admin
  class GasContractsController < ApplicationController

    def index
      @contracts = GasContract.all
    end

    def new
      @contract = GasContract.new
    end

    def create
      @contract = GasContract.new(
          params[:supplier],
          params[:offer_name],
          params[:subscription_base_price_month],
          params[:kwh_price_base],
          params[:low_kw_consumption_per_year],
          params[:high_kw_consumption_per_year]
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