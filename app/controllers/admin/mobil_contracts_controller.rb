module Admin
  class MobilContractsController < ApplicationController

  	def index
  		@contracts = MobilContract.all.sort_by(&:supplier)
  	end

  	def show
  		@contract = MobilContract.find(params[:id])
  	end

  	def new
  		@contract = MobilContract.new
  	end

  	def create
  		my_params = params[:mobil_contract]
  		@contract = MobilContract.new(supplier: my_params[:supplier],
                                  offer_name: my_params[:offer_name],
                                	line_service_price: my_params[:line_service_price],
                                  sim_card_price: my_params[:sim_card_price],
                                  engagement: my_params[:engagement],
                                  add_phone: my_params[:add_phone],
                                  bundle_price: my_params[:bundle_price],
                                  bundle_gbyte:my_params[:bundle_gbyte], 
                                  calls_france:my_params[:calls_france],
                                  calls_europe:my_params[:calls_europe],
                                  gbyte_europe:my_params[:gbyte_europe],
                                  calls_international:my_params[:calls_international],
                                  net_international:my_params[:net_international]
                                  )
      if @contract.save
        flash[:success] = 'Contract Mobil created'
        redirect_to admin_mobil_contracts_path
      else
        render 'new'
      end
  	end

  	def edit
  		@contract = MobilContract.find(params[:id])
  	end

  	def update
  		@contract = MobilContract.find(params[:id])
      if @contract.update(contract_params)
        flash[:success] = 'Contract Mobil edited'
        redirect_to admin_mobil_contracts_path
      else
        render 'edit'
      end
  	end

  	def destroy
  		@contract = MobilContract.find(params[:id])
      @contract.destroy
      flash[:success] = 'Mobil Simulation successfully deleted'
      redirect_to admin_mobil_contracts_path
  	end

  	private

    def contract_params
      params.require(:mobil_contract).permit(:supplier,
                                           :offer_name,
                                           :line_service_price,
                                           :sim_card_price,
                                           :engagement,
                                           :add_phone,
                                           :bundle_price,
                                           :bundle_gbyte,
                                           :calls_france,
                                           :calls_europe,
                                           :gbyte_europe,
                                           :calls_international,
                                           :net_international)
    end

  end
end