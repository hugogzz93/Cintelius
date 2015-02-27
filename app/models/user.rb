class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_and_belongs_to_many :products
  has_many :orders, dependent: :destroy
  has_many :offers, dependent: :destroy
  has_many :combos, dependent: :destroy
  has_many :product_scores
  has_many :review_tickets, dependent: :destroy
  has_one :service_grade
  has_one :user_details, dependent: :destroy

end
