class Order < ActiveRecord::Base

  belongs_to :user
  has_many :line_items

  monetize :total_cents, numericality: true
  validates :stripe_charge_id, presence: true

  after_create :update_inventory

  def self.create_order_from_cart!(attrs = {})
    order = self.new(
      email: attrs[:email],
      stripe_charge_id: attrs[:stripe_token],
      total_cents: attrs[:cart_total]
    )
    attrs[:products].each do |product_id, details|
      if product = Product.find_by(id: product_id)
        quantity = details['quantity'].to_i
        order.line_items.new(
          product: product,
          quantity: quantity,
          item_price: product.price,
          total_price: product.price * quantity
        )
      end
    end
    order.save!
    Mailer.order_email(order).deliver
    order
  end

  private

  def update_inventory
    line_items.each do |item|
      product = item.product
      product.quantity -= item.quantity
      product.save!
    end
  end

end
