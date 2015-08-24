ENV["RAILS_ENV"] ||= 'test'
require File.expand_path("../../config/environment", __FILE__)
require 'rspec/rails'
require 'factory_girl'
FactoryGirl.factories.clear
FactoryGirl.find_definitions

RSpec.configure do |config|
  config.infer_spec_type_from_file_location!
  
  config.before(:suite) do
    DatabaseCleaner.strategy = :transaction
    DatabaseCleaner.clean_with(:truncation)
    Rails.application.load_seed # loading seeds
  end

  def login_user(user)
		logged_in_user = User.authenticate(user.email, user.password)
		if logged_in_user.present?
			session[:user_id] = logged_in_user.id
		end
	end
end