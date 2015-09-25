class AddFieldsToUserDetails < ActiveRecord::Migration
  def change
  	add_column :user_details, :fiscal_denomination, :string
  	add_column :user_details, :city, :string
  	add_column :user_details, :state, :string
  	add_column :user_details, :fiscal_address, :string
  	add_column :user_details, :postal_code, :string
  	add_column :user_details, :RFC, :string

  end
end
