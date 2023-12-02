class CreateUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :users do |t|
      t.string :email, index: { unique: true, name: 'index_users_on_email' }
      t.string :password_digest

      t.string :first_name
      t.string :last_name

      t.timestamps
    end
  end
end