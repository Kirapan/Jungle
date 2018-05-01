class OrdersController < ApplicationController

  def show
    @order = Order.find(params[:id])
  end

  def create
    checkout_form = CheckoutForm.new(
      email: params[:stripeEmail],
      stripe_token: params[:stripeToken]
    )
    if checkout_form.valid?
      begin
        charge = PaymentGatewayService.new(
          cart_total,
          checkout_form.stripe_token
        ).process_payment
        order = Order.create_order_from_cart!(
          cart_total: cart_total,
          stripe_token: charge.id,
          email: checkout_form.email,
          products: cart
        )
        empty_cart!
        redirect_to order, success: 'Your Order has been placed.'
      rescue Stripe::CardError => e
        redirect_to cart_path, flash: { error: e.message }
      end
    else
      redirect_to cart_path, flash: { error: checkout_form.errors.full_messages.first }
    end

  end

  private

  def empty_cart!
    # empty hash means no products in cart :)
    update_cart({})
  end

  # returns total in cents not dollars (stripe uses cents as well)
  def cart_total
    total = 0
    cart.each do |product_id, details|
      if p = Product.find_by(id: product_id)
        total += p.price_cents * details['quantity'].to_i
      end
    end
    total
  end

end
