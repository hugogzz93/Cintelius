class CreateReviewTickets < ActiveRecord::Migration
  def change
    create_table :review_tickets do |t|
    	t.references :reviewable, polymorphic: true, index: true
    	

      t.timestamps null: false
    end
  end
end
