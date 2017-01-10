class AddPlaceIdToProviderProfile < ActiveRecord::Migration
  def change
    add_reference :provider_profiles, :place, index: true, foreign_key: true
  end
end
