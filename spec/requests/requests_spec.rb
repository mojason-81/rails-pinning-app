require "spec_helper"

RSpec.describe "Our Application Routes" do
  before(:all) do
    @pin_hash = { 
        title: "Rails Wizard", 
        url: "http://railswizard.org", 
        slug: "rails-wizard", 
        text: "A fun and helpful Rails Resource",
        category_id: 2}
    @pin = Pin.create(@pin_hash)
    get "/pins/name-#{@pin.id}"
  end

  after(:all) do
    pin = Pin.find_by_slug("rails-wizard")
    if !pin.nil?
      pin.destroy
    end
  end

  describe "GET /pins/name-:slug" do
    it 'populates the pin variable with the appropriate pin' do
      expect(assigns[:pin]).to eq(@pin)
    end

  	it 'renders the pins/show template' do
  		expect(response).to render_template("pins/show")
  	end  	
  end
end