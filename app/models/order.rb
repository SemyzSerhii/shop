class Order < ApplicationRecord
  belongs_to :user, optional: true
  has_many :line_items, dependent: :destroy

  validates :email, format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i }, uniqueness: true, presence: true
  validates :name, presence: true, length: { minimum: 3 }, uniqueness: true
  validates :address, presence: true, length: { minimum: 10 }

  after_save :send_order_user, :send_order_admin

  def add_line_items_from_cart(cart)
    cart.line_items.each do |item|
      item.cart_id = nil
      line_items << item
    end
  end

  def total_price
    line_items.to_a.sum { |item| item.total_price }
  end

  def send_order_user
    UserMailer.order(self, self.email).deliver_now
  end

  def send_order_admin
    UserMailer.order(self, 'admin').deliver_now
  end
end
