class AddNombreEstablecimientoToProviderProfile < ActiveRecord::Migration
  def up
    # otherwise new not-null fields will complain
    say_with_time "WARNING: wiping all provider items, provider clients and provider profiles" do
      ProviderItem.destroy_all
      ProviderClient.destroy_all
      ProviderProfile.destroy_all
    end

    add_column :provider_profiles,
               :nombre_establecimiento,
               :string,
               null: false
  end

  def down
    remove_column :provider_profiles, :nombre_establecimiento
  end
end
