class AddAmazonImageUrlToProduct < ActiveRecord::Migration[5.2]
  def change
    add_column :products, :amazon_image_url, :string
  end
end
