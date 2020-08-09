class AddInvestmentTypeToListings < ActiveRecord::Migration[6.0]
  def change
    add_column :listings, :investment_type, :string
  end
end
