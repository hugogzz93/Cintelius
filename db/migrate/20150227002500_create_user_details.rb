class CreateUserDetails < ActiveRecord::Migration
  def change
    create_table :user_details do |t|
    	t.belongs_to :user
    	t.integer :telephone
    	t.string :address
    	t.string :organization

      t.timestamps null: false
    end
  end
end
