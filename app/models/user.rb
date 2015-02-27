class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_and_belongs_to_many :products
  has_many :orders
  has_many :offers
  has_many :combos
  # has_many :product_scores
  has_many :review_tickets
  # has_one :service_grade

end
