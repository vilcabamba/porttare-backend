class CreateProviderClients < ActiveRecord::Migration
  def change
    create_table :provider_clients do |t|
      t.references :provider_profile, index: true, foreign_key: true
      t.text :notes
      t.string :ruc
      t.string :name
      t.string :address
      t.string :phone
      t.string :email

      t.timestamps null: false
    end
  end
end
