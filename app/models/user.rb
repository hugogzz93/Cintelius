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
  has_many :product_scores
  has_many :review_tickets, dependent: :destroy
  has_one :service_score
  has_one :user_detail, dependent: :destroy

  after_create :setup_service_score

  def authorized_products
    self.products.collect {|product| product.id}
  end

  def is_buyer?
    self.user_detail.is_buyer?
  end

  def is_seller?
    self.user_detail.is_seller?
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

  def closed_orders
    
  end

  def get_organization
    self.user_detail.organization
  end

end
