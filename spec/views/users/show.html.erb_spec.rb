require 'spec_helper'

RSpec.describe "users/show", type: :view do
  before(:each) do
    @user = FactoryGirl.create(:user)
    @pins = @user.pins
  end

  after(:each) do
    if !User.find_by_first_name("Skillcrush").nil?
      User.find_by_first_name("Skillcrush").destroy
    end
  end

  it "renders attributes in <p>" do
    render
    #expect(rendered).to match(@user.first_name)
    #expect(rendered).to match(@user.last_name)
    #expect(rendered).to match(@user.email)
    @user.pins.each do |pin|
      expect(rendered).to match(pin.title)
    end
  end
end
