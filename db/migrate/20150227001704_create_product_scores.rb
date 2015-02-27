class CreateProductScores < ActiveRecord::Migration
  def change
    create_table :product_scores do |t|
    	t.belongs_to :user
    	t.belongs_to :product
    	t.decimal :total_score
    	t.integer :total_reviews
      t.timestamps null: false
    end
  end
end
