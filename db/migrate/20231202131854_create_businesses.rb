class CreateBusinesses < ActiveRecord::Migration[7.0]
  def change
    create_table :businesses do |t|
      t.string :name, index: { unique: true, name: 'index_businesses_on_name' }
      t.decimal :shares_available, precision: 10, scale: 2, default: 0.0

      t.timestamps
    end
  end
end
