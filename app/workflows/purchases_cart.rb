class PurchasesCart
  attr_accessor :user, :stripe_token,
      :purchase_amount, :success, :payment

  def initialize(user: nil, stripe_token:, purchase_amount_cents: nil)
    @user = user
    @stripe_token = stripe_token
    @purchase_amount = Money.new(purchase_amount_cents)
    @success = false
    #@continue = true
    #@expected_ticket_ids = expected_ticket_ids.split(" ").map(&:to_i).sort
    #@payment_reference = payment_reference || Payment.generate_reference
  end

  def run
    Payment.transaction do
      purchase_tickets
      create_payment
      charge
      @success = payment.succeeded?
    end
  end
=begin
  def run
    Payment.transaction do
      raise PreExistingPaymentException.new(purchase) if existing_payment
      unless pre_purchase_valid?
        raise CharSetupValidityException.new(
          user: user,
          expected_purchase_cents: purchase_amount.to_i,
          expected_ticket_ids: expected_ticket_ids)
      end
      update_tickets
      create_payment
      on_success
    end
  rescue
    on_failure
    raise
  end

=end

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

  def existing_payment
    Payment.find_by(reference: payment_reference)
  end

  def pre_purchase
    return true if existing_payment
    unless pre_purchase_valid?
      @continue = false
      return
    end
    update_tickets
    create_payment
    @continue = true
  end

  def redirect_on_success_url
    nil
  end

  def create_payment
    self.payment = Payment.create!(payment_attributes)
    #self.payment = existing_payment || Payment.new
    #payment.update!(payment_attributes)
    payment.create_line_items(tickets)
  end

  def payment_attributes
    {user_id: user.id, price_cents: purchase_amount.cents,
     status: "created", reference: Payment.generate_reference,
     payment_method: "stripe"}
  end

  def charge
    charge = StripeCharge.charge(token: stripe_token, payment: payment)
    payment.update!(
      status: charge.status, response_id: charge.id,
      full_response: charge.to_json)
  end

  def success?
    success
  end

  def calculate_success
    payment.succeeded?
  end

  def post_purchase
    return unless @continue
    @continue = calculate_success
  end


end
