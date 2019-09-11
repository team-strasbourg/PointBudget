class GasSimulation < ApplicationRecord
  belongs_to :full_simulation
  has_many :join_table_gases
  has_many :gas_contracts, through: :join_table_gases

  # before_create :estimation

  private

  def estimation(yearly_cost, yearly_consumption, floor_space, heat_type,water_cooking_type, nb_residents)
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
      yearly_consumption = *100*first_factor + nb_residents*second_factor
    end
    comparison(yearly_cost, yearly_consumption)
  end

  def comparison(yearly_cost, yearly_consumption)
    first_filter = GasContract.all.select{ |contract|
      yearly_consumption.between?(contract.low_kw_consumption_per_year * 1000, contract.high_kw_consumption_per_year * 1000)
    }
    second_filter = first_filter.select{ |contract|
      yearly_cost > (contract.kwh_price_base * yearly_consumption + contract.subscription_base_price_month * 12)
    }
    create_join_table_gas(second_filter)

  end

  def create_join_table_gas(filter)
    filter.each do |contract|
      JoinTableGasSimulationContract.create(gas_simulation: self, gas_contract: contract)
    end
  end
end
