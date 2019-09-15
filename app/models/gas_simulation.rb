# frozen_string_literal: true

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
            format: { with: /\A(Gaz|Electricite)\Z/}
  validates :water_cooking_type,
            allow_blank: true,
            format: { with: /\A(Gaz|Electricite)\Z/}
  validates :residents_number,
            allow_blank: true,
            numericality: { greater_than_or_equal_to: 1 }
  validates :gas_use,
            presence: true,
            numericality: { greater_than_or_equal_to: 0, only_integer: true }


  def assign_params_from_controller(params)
    @params = params
  end

  def estimation(yearly_cost, yearly_consumption, floor_space, heat_type, water_cooking_type, nb_residents )
    yearly_cost = yearly_cost.to_i
    yearly_consumption = yearly_consumption.to_i
    floor_space = floor_space.to_i
    nb_residents = nb_residents.to_i
    if verify_nilness_params(yearly_cost, yearly_consumption, floor_space, heat_type, water_cooking_type, nb_residents)
      first_factor = heat_type == 'Gaz' ? 1 : 0
      second_factor = water_cooking_type == 'Gaz' ? 1 : 0
      yearly_consumption = floor_space * 100 * first_factor + consumption_people(nb_residents) * second_factor if yearly_consumption.zero?
      return [yearly_cost, yearly_consumption]
    else
      return [false, -1]
    end
  end

  def comparison(yearly_cost, yearly_consumption)
    first_filter = GasContract.all.select { |contract|
      yearly_consumption.between?(contract.low_kw_consumption_per_year * 1000, contract.high_kw_consumption_per_year * 1000)
    }
    second_filter = first_filter.select{ |contract|
      yearly_cost > (contract.kwh_price_base * yearly_consumption + contract.subscription_base_price_month * 12)
    }
    max_save = 0
    second_filter.each do |contract|
      savings = yearly_cost - (contract.kwh_price_base * yearly_consumption + contract.subscription_base_price_month * 12)
      if savings > max_save
        max_save = savings
      end
    end
    [max_save.round(2), second_filter]
  end

  def create_join_table_gas(filter)
    filter.each do |contract|
      JoinTableGasSimulationContract.create(gas_simulation: self, gas_contract: contract)
    end
  end

  def consumption_people(nb_residents)
    hash = {
              1 => 1630,
              2 => 2945,
              3 => 4265,
              4 => 5320,
              5 => 6360,
           }
    if hash[nb_residents].nil?
      hash[5] + (nb_residents - 5) * 1000
    else
      hash[nb_residents]
    end
  end

  def verify_nilness_params(yearly_cost, yearly_consumption, floor_space, heat_type, water_cooking_type, nb_residents)
    if yearly_cost.zero?
      false
    else
      if yearly_consumption.zero?
        if [floor_space, nb_residents].include?(0) || [heat_type, water_cooking_type].include?('')
          false
        else
          true
        end
      else
        true
      end
    end
  end
end
