class OfferDetail < ActiveRecord::Base
	belongs_to :order
    belongs_to :offer

    validates :units, presence: true, numericality: true
    
    enum status: [:provider, :client, :both, :denied_by_provider]
end
