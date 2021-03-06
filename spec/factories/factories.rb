FactoryGirl.define do
  factory :pin do
    sequence(:slug) { |n| "slug#{n}"}
    title "Rails Cheatsheet"
    url "http://rails-cheat.com"
    text "A great tool for beginning developers"
    #slug
    #category { Category.find_by_id(2) }
    category_id 2
  end
  
  factory :user do
    #sequence :email do |n|
     # "coder#{n}@skillcrush.com"
    #end
    sequence(:email) { |n| "coder#{n}@skillcrush.com" } 
    first_name "Skillcrush"
    last_name "Coder"
    password "secret"
   
    after(:create) do |user|
      3.times do
        user.pinnings.create(pin: FactoryGirl.create(:pin))
      end
    end
  end
   
  factory :pinning do
    pin
    user
  end
end