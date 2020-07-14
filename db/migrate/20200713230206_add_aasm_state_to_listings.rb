class AddAasmStateToListings < ActiveRecord::Migration[6.0]
  def change
    add_column :listings, :aasm_state, :string
  end
end
