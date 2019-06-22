class CreateProducts < ActiveRecord::Migration[5.2]
  def change
    create_table :products do |t|
      # Internals
      t.string :status, default: Product::STATUSES[:inactive]

      # Source: https://www.amazon.ca/gp/seller/asin-upc-isbn-info.html
      t.string :asin, limit: 10
      t.string :title
      t.integer :best_seller_rank
      t.string :category

      # Dimensions
      t.integer :length_in_hundreds
      t.integer :width_in_hundreds
      t.integer :height_in_hundreds

      t.timestamps
    end

    add_index :products, :asin, unique: true
  end
end
