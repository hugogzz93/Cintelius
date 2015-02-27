class ChangeDefaultStatusesTo0 < ActiveRecord::Migration
  def change
  	change_column_default :offers, :status, 0
  	change_column_null :offers, :status, false
  	change_column_null :combos, :status, false
  	change_column_null :offer_details, :status, false
  end
end
