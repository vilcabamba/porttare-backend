class CreateUserRefers < ActiveRecord::Migration
  def change
    create_table :user_refers do |t|
      t.integer :user_id, null: false
      t.integer :guest_id, null: false
      t.timestamps null: false
    end
  end
end
