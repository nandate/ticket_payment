class AddsPlanToCart

  attr_accessor :user, :plan, :result

  def initialize(user:, plan:)
    @user = user
    @plan = plan
    @result = nil
  end

  def run
    @result = SubScription.create!(
      user: user, plan: plan,
      start_date: Time.zone.now.to_date,
      end_date: plan.end_date_from,
      status: :waiting)
  end

  def success?
    result.valid?
  end

end
