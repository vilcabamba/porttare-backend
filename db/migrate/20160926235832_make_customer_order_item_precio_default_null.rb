class MakeCustomerOrderItemPrecioDefaultNull < ActiveRecord::Migration
  def up
    change_column_default(
      :customer_order_items,
      :provider_item_precio_cents,
      :null
    )
  end

  def down
    change_column_default(
      :customer_order_items,
      :provider_item_precio_cents,
      0
    )
  end
end
