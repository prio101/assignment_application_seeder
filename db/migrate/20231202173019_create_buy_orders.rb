class CreateBuyOrders < ActiveRecord::Migration[7.0]
  def change
    create_table :buy_orders do |t|
      t.decimal :quantity, precision: 10, scale: 2, default: 0.0
      t.decimal :price, precision: 10, scale: 2, default: 0.0
      t.references :buyer, foreign_key: { to_table: :users }
      t.references :business, foreign_key: true
      t.string :status, default: 'pending'
      t.timestamps
    end
  end
end
