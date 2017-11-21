FactoryGirl.define do
  factory :subscription do
    user nil
    plan nil
    start_date "2017-11-21"
    end_date "2017-11-21"
    status 1
    payment_method "MyString"
    remote_id "MyString"
  end
end
