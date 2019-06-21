class CreateScraperExpression < ActiveRecord::Migration[5.2]
  def change
    create_table :scraper_expressions do |t|
      t.string :key, limit: 40
      t.string :expression
    end

    add_index :scraper_expressions, :key
  end
end
