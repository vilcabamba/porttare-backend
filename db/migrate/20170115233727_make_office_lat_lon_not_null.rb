class MakeOfficeLatLonNotNull < ActiveRecord::Migration
  def up
    say_with_time "WARNING: setting provider offices lat/lon to a default place" do
      ProviderOffice.find_each do |provider_office|
        if provider_office.place.blank?
          provider_office.place = Place.first
        end
        provider_office.update!(
          lat: "-3.792134532423",
          lon: "72.43214254556"
        )
      end
    end
    change_column :provider_offices, :lat, :string, null: false
    change_column :provider_offices, :lon, :string, null: false
  end

  def down
    change_column :provider_offices, :lat, :string, null: true
    change_column :provider_offices, :lon, :string, null: true
  end
end
