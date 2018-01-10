class StripeToken

  attr_accessor :credit_card_number, :expiration_month,
      :expiration_year, :cvc

  def initialize(credit_card_number: nil, expiration_month: nil,
      expiration_year: nil, cvc:nil)
    @credit_card_number = credit_card_number
    @expiration_month = expiration_month
    @expiration_year = expiration_year
    @cvc = cvc
  end

  def token
    @token ||= create_token
  end

  private def retrieve_token
    Stripe::Token.retrieve(stripe_token)
  end

  private def create_token
    Stripe::Token.create(
        card: {number: credit_card_number, exp_month: expiration_month,
               exp_year: expiration_year, cvc: cvc})
  end

  delegate :id, to: :token

  def to_s
    "STRIPE TOKEN: #{id}"
  end

  def inspect
    "STRIPE TOKEN #{id}"
  end

end
