FactoryGirl.define do
	#sequence :slug do |n|
	#	"slug#{n}"
	#end

	sequence :email do |n|
		"coder#{n}@skillcrush.com"
	end
=begin
	factory :pin do
		sequence(:slug) { |n| "slug#{n}"}
		title "Rails Cheatsheet"
		url "http://rails-cheat.com"
		text "A great tool for beginning developers"
		slug
		category Category.find_by_name("rails")
	end
=end
  factory :user do 
    #sequence(:email) { |n| "coder#{n}@skillcrush.com" }
    email
    first_name "Skillcrush"
    last_name "Coder"
    password "secret"

    #after(:create) do |user|
    #	create_list(:pin, 3)
    #end
  end
end 