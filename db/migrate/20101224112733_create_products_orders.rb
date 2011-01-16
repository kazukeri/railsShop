class CreateProductsOrders < ActiveRecord::Migration
  def self.up
    create_table :products_orders do |t|
      t.integer :order_id
      t.integer :product_id
      t.timestamps
    end
  end

  def self.down
    drop_table :products_orders
  end
end
