class AddDefaultStatusToOfferDetails < ActiveRecord::Migration
  def change
  	change_column_default :offer_details, :status, 0
  	change_column_null :offer_details, :status, false
  end
end
