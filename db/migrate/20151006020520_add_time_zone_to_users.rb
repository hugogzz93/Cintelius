class AddTimeZoneToUsers < ActiveRecord::Migration
  def change
    add_column :user_details, :time_zone, :string, default: "Monterrey"
    change_column_null :user_details, :time_zone, false

  end
end
