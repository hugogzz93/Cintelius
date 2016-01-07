class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :user_products, dependent: :destroy
  has_many :products, through: :user_products
  has_many :orders, dependent: :destroy
  has_many :offers, dependent: :destroy
  has_many :combos, dependent: :destroy
  has_many :order_histories, dependent: :destroy
  has_many :offer_histories, dependent: :destroy
  has_many :combo_histories, dependent: :destroy
  has_many :product_scores, dependent: :destroy
  has_many :review_tickets, dependent: :destroy
  has_one :service_score, dependent: :destroy
  has_one :user_detail, dependent: :destroy

  after_create :setup_service_score
  # accepts_nested_attributes_for :user_detail

  def authorized_products
    self.products.collect {|product| product.id}
  end

  def is_buyer?
    self.user_detail.is_buyer? || self.user_detail.is_admin?
  end

  def is_seller?
    self.user_detail.is_seller? || self.user_detail.is_admin?
  end

  def is_admin?
    self.user_detail.is_admin?
  end

  def setup_service_score
    self.create_service_score
  end

  def setup_product_score(product_id)
    self.product_scores.create(product_id: product_id)
  end

  def get_service_score
    self.service_score.get_score
  end

  def time_zone
    self.user_detail.time_zone
  end

  def closed_orders
    
  end

  def get_address
    self.user_detail.address
  end

  def get_organization
    self.user_detail.organization
  end

  def get_telephone
    self.user_detail.telephone
  end

  def make_admin
    self.user_detail.make_admin
  end

  # def get_recent_orders
  #   # agarra la combinacion de 
  #   recent_orders = current_user.order_histories.last(5)
  # end

end
