class GasSimulation < ApplicationRecord
  belongs_to :full_simulation
  has_many :join_table_gases
  has_many :gas_contracts, through: :join_table_gases
  validates :actual_price_paid,
            presence: true,
            numericality: { greater_than_or_equal_to: 0 }
  validates :gas_cost_saved,
            presence: true,
            numericality: { greater_than_or_equal_to: 0 }
  validates :floor_space,
            allow_blank: true,
            numericality: { greater_than_or_equal_to: 9 }
  validates :heat_type,
            allow_blank: true,
            format: { in: ["Gaz" "Electricite"] }


  def assign_params_from_controller(params)
    @params = params
  end

  def estimation
    yearly_cost = @params[:yearly_cost].to_i
    yearly_consumption = @params[:yearly_consumption].to_i
    floor_space = @params[:floor_space].to_i
    heat_type = @params[:heat_type]
    water_cooking_type = @params[:water_cooking_type]
    nb_residents = @params[:nb_residents].to_i
    if yearly_consumption.nil?
      first_factor = if heat_type == 'Gaz'
                       1
                     else
                       0
                     end
      second_factor = if water_cooking_type == 'Gaz'
                        1
                      else
                        0
                      end
      yearly_consumption = floor_space*100*first_factor + nb_residents*second_factor
    end
    [yearly_cost, yearly_consumption]

  end

  def comparison(yearly_cost, yearly_consumption)
    first_filter = GasContract.all.select{ |contract|
      yearly_consumption.between?(contract.low_kw_consumption_per_year * 1000, contract.high_kw_consumption_per_year * 1000)
    }
    second_filter = first_filter.select{ |contract|
      yearly_cost > (contract.kwh_price_base * yearly_consumption + contract.subscription_base_price_month * 12)
    }
    max_save = 0
    second_filter.each do |contract|
      if contract.kwh_price_base * yearly_consumption + contract.subscription_base_price_month*12 > max_save
        max_save = contract.kwh_price_base * yearly_consumption + contract.subscription_base_price_month*12
      end
    end
    cost_saved = if max_save == 0
                   0
                 else
                   yearly_cost - max_save
                 end
    [cost_saved, second_filter]
  end

  def create_join_table_gas(filter)
    filter.each do |contract|
      JoinTableGasSimulationContract.create(gas_simulation: self, gas_contract: contract)
    end
  end
end
