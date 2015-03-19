class AddAccountCredentialsToUserDetail < ActiveRecord::Migration
  def change
  	add_column :user_details, :credentials, :integer
  end
end
