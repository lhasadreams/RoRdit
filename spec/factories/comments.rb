FactoryGirl.define do
  factory :comment do
    comment "Thank you for sharing this link."
    user_id nil
    link_id nil
    username nil
  end
end