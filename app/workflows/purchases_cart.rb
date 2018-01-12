class PurchasesCart
  attr_accessor :user, :stripe_token,
      :purchase_amount, :success,
      :payment, :expected_ticket_ids

  def initialize(user: nil, stripe_token:, purchase_amount_cents: nil, expected_ticket_ids: "")
    @user = user
    @stripe_token = stripe_token
    @purchase_amount = Money.new(purchase_amount_cents)
    @success = false
    @continue = true
    @expected_ticket_ids = expected_ticket_ids.split(" ").map(&:to_i).sort
    #@payment_reference = payment_reference || Payment.generate_reference
  end

  def run
    Payment.transaction do
      pre_purchase
      charge
      post_purchase
      @success = @continue
    end
  rescue ActiveRecord::ActiveRecordError => e
    Rails.logger.error("ACTIVE RECORD ERROR IN TRANSACTION")
    Rails.logger.error(e)
  end

  def pre_purchase_valid?
    purchase_amount == tickets.map(&:price).sum &&
        expected_ticket_ids == tickets.map(&:id).sort
  end

  def tickets
    @tickets ||= @user.tickets_in_cart
    #@tickets ||= @user.tickets_in_cart.select do |ticket|
    #  ticket.payment_reference == payment_reference
    #end
  end

  def purchase_tickets
    tickets.each(&:purchased!)
  end


  def pre_purchase
    unless pre_purchase_valid?
      @continue = false
      return
    end
    purchase_tickets
    create_payment
    @continue = true
  end

  def redirect_on_success_url
    nil
  end

  def create_payment
    self.payment = Payment.create!(payment_attributes)
    payment.create_line_items(tickets)
  end

  def payment_attributes
    {user_id: user.id, price_cents: purchase_amount.cents,
     status: "created", reference: Payment.generate_reference,
     payment_method: "stripe"}
  end

  def charge
    return unless @continue
    charge = StripeCharge.charge(token: stripe_token, payment: payment)
    payment.update!(
      status: charge.status, response_id: charge.id,
      full_response: charge.to_json)
    reverse_purchase if payment.failed?
  end

  def success?
    success
  end

  def unpurchase_tickets
    tickets.each(&:waiting!)
  end

  def reverse_purchase
    unpurchase_tickets
    @continue = false
  end

  def calculate_success
    payment.succeeded?
  end

  def post_purchase
    return unless @continue
    @continue = calculate_success
  end


end
