class Order < ActiveRecord::Base
	belongs_to :User
	has_many :offers, through :offer_details, dependent :destroy
	has_many :combos, dependent :destroy

end
