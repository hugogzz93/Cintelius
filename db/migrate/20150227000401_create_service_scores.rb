class CreateServiceScores < ActiveRecord::Migration
  def change
    create_table :service_scores do |t|
    	t.belongs_to :user
    	t.decimal :total_score
    	t.integer :total_reviews
      t.timestamps null: false
    end
  end
end
