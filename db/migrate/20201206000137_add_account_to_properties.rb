class AddAccountToProperties < ActiveRecord::Migration[6.0]
  disable_ddl_transaction!

  def change
    add_reference :properties, :account, index: {algorithm: :concurrently}
  end
end
