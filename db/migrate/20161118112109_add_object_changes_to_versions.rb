# This migration adds the optional `object_changes` column, in which PaperTrail
# will store the `changes` diff for each update event. See the readme for
# details.
class AddObjectChangesToVersions < ActiveRecord::Migration
  # The largest text column available in all supported RDBMS.
  # See `create_versions.rb` for details.
  # TEXT_BYTES = 1_073_741_823
  # no need for limit as we're using postgresql JSON
  # native column type

  def change
    add_column :versions, :object_changes, :json#, limit: TEXT_BYTES
  end
end