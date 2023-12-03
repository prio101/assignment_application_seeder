class AddStatusToBusiness < ActiveRecord::Migration[7.0]
  def change
    add_column :businesses, :status, :string, default: "active"
  end
end
