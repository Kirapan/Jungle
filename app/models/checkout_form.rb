class CheckoutForm
  include ActiveModel::Model

  attr_reader :email
  attr_accessor :stripe_token

  validates :email, presence: true, format: { with: /\w+@\w+\.\w+/i }
  validates :stripe_token, presence: true

  def email=(email_input)
    @email = email_input.to_s.downcase
  end
end
