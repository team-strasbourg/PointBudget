class MobilSimulation < ApplicationRecord
	has_many :join_table_mobil_contracts
	has_many :mobil_contracts, through: :join_table_mobil_contracts
	belongs_to :full_simulation

	validates :actual_price_paid,
            presence: true,
            numericality: { greater_than_or_equal_to: 0 }

  validates :mobil_cost_saved,
            presence: true,
            numericality: { greater_than_or_equal_to: 0 }

	# Set the user of the mobil simulation
  def user
    self.full_simulation.user
  end

  # Def comparison
  def comparison(monthly_cost, bundle_go, calls_europe, calls_international, net_international)
  	monthly_cost = monthly_cost.to_f
  	bundle_go = bundle_go.to_i
  	first_filter = MobilContract.all.select { |contract| contract.bundle_gbyte >= bundle_go}
  	second_filter = first_filter.select { |contract| contract.calls_europe == calls_europe}
  	third_filter = second_filter.select { |contract| contract.calls_international == calls_international}
  	fourth_filter = third_filter.select { |contract| contract.net_international == net_international}

  	fifth_filter = fourth_filter.select { |contract| contract.bundle_price < monthly_cost } # filter by price
  	max_save = 0
    all_savings = []

    fifth_filter.each do |contract|
      savings = ((monthly_cost - contract.bundle_price) * 12 ).round(2) # Find the best price
      if savings > max_save
        max_save = savings # Save the best price
      end
      all_savings << savings # Save the differences in an array, it will be use after
    end

  	[max_save.round(2), fifth_filter, all_savings] # return the max save, all the better contracts and the savings for each contracts
  end

end
