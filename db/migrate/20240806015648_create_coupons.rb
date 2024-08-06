class CreateCoupons < ActiveRecord::Migration[7.1]
  def change
    create_table :coupons do |t|
      t.string :name, null: false
      t.string :code, null: false
      t.integer :discount_type, null: false, default: 0
      t.integer :discount_amount, null: false
      t.references :merchant, null: false, foreign_key: true
      t.boolean :active, default: false

      t.timestamps
    end
  end
end
