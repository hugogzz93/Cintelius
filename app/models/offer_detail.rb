class OfferDetail < ActiveRecord::Base
	belongs_to :order
    belongs_to :offer
    
    enum status: %w(provider client both denied_by_provider)
end
