require 'spec_helper'
FactoryGirl.find_definitions

RSpec.describe "users/edit", type: :view do
  before(:each) do
    @user = FactoryGirl.create(:user)
  end

  after(:each) do
    if !User.find_by_first_name("Skillcrush").nil?
      User.find_by_first_name("Skillcrush").destroy
    end
  end

  it "renders the edit user form" do
    render

    assert_select "form[action=?][method=?]", user_path(@user), "post" do

      assert_select "input#user_first_name[name=?]", "user[first_name]"

      assert_select "input#user_last_name[name=?]", "user[last_name]"

      assert_select "input#user_email[name=?]", "user[email]"

      assert_select "input#user_password[name=?]", "user[password]"
    end
  end
end
