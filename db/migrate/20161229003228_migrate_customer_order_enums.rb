class MigrateCustomerOrderEnums < ActiveRecord::Migration
  def up
    say_with_time "WARNING: attempting to fix current customer orders' statuses" do
      CustomerOrder.where(status: "0").update_all(status: :in_progress)
      CustomerOrder.where(status: "1").update_all(status: :submitted)
    end

    change_table :customer_orders do |t|
      t.change :status, :string, default: CustomerOrder.status.values.first
      t.change :forma_de_pago, :string
    end
  end

  def down
    raise ActiveRecord::IrreversibleMigration
  end
end
