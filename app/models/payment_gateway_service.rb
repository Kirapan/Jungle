class PaymentGatewayService
  def initialize(cart_total, stripe_token)
    @cart_total = cart_total
    @stripe_token = stripe_token
  end

  def process_payment
    charge = create_charge(@cart_total, @stripe_token)
  end

  private

  def create_charge(cart_total, stripe_token)
    Stripe::Charge.create(
      source:      stripe_token,
      amount:      cart_total, # in cents
      description: "Khurram Virani's Jungle Order",
      currency:    'cad'
    )
  end
end
