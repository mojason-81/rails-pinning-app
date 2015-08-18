require 'spec_helper'
FactoryGirl.find_definitions

RSpec.describe PinsController do
  before(:each) do
    @user = FactoryGirl.create(:user)
    login_user(@user)
  end

  after(:each) do
    if !@user.destroyed?
      @user.destroy
    end
  end

	describe "GET index" do
		it 'renders the index template' do
			get :index
			expect(response).to render_template("index")
		end

		it 'populates @pins with user pins' do
			get :index
			expect(assigns[:pins]).to eq(Pin.where("user_id=?", session[:user_id]))
		end
	end

	describe "GET new" do
    it 'responds with successfully' do
      get :new
      expect(response.success?).to be(true)
    end
    
    it 'renders the new view' do
      get :new      
      expect(response).to render_template(:new)
    end
    
    it 'assigns an instance variable to a new pin' do
      get :new
      expect(assigns(:pin)).to be_a_new(Pin)
    end
  end
  
  describe "POST create" do
    before(:each) do
      @pin_hash = { 
        title: "Rails Wizard", 
        url: "http://railswizard.org", 
        slug: "rails-wizard", 
        text: "A fun and helpful Rails Resource",
        category_id: 2}
    end
    
    after(:each) do
      pin = Pin.find_by_slug("rails-wizard")
      if !pin.nil?
        pin.destroy
      end
    end
    
    it 'responds with a redirect' do
      post :create, pin: @pin_hash
      expect(response.redirect?).to be(true)
    end
    
    it 'creates a pin' do
      post :create, pin: @pin_hash  
      expect(Pin.find_by_slug("rails-wizard").present?).to be(true)
    end
    
    it 'redirects to the show view' do
      post :create, pin: @pin_hash
      expect(response).to redirect_to(pin_url(assigns(:pin)))
    end
    
    it 'redisplays new form on error' do
      # The title is required in the Pin model, so we'll
      # delete the title from the @pin_hash in order
      # to test what happens with invalid parameters
      @pin_hash.delete(:title)
      post :create, pin: @pin_hash
      expect(response).to render_template(:new)
    end
    
    it 'assigns the @errors instance variable on error' do
      # The title is required in the Pin model, so we'll
      # delete the title from the @pin_hash in order
      # to test what happens with invalid parameters
      @pin_hash.delete(:title)
      post :create, pin: @pin_hash
      expect(assigns[:errors].present?).to be(true)
    end
  end

  describe "GET edit" do
    before(:each) do
      @pin_hash = { 
        title: "Rails Wizard", 
        url: "http://railswizard.org", 
        slug: "rails-wizard", 
        text: "A fun and helpful Rails Resource",
        category_id: 2}
      post :create, pin: @pin_hash
      @pin = Pin.find_by_slug("rails-wizard")
    end

    after(:each) do
      @pin = Pin.find_by_slug("rails-wizard")
      if !@pin.nil?
        @pin.destroy
      end
    end

    it 'responds with success' do
      get :edit, {:id => @pin.to_param}
      expect(response.success?).to be(true)
    end

    it 'renders the edit template' do
      get :edit, {:id => @pin.to_param}
      expect(response).to render_template("edit")
    end

    it 'assigns @pin to the Pin with appropriate id' do
      @pin = Pin.find_by_id(@pin.id)
      expect(assigns[:pin]).to eq(@pin)
    end
  end

  describe "POST update" do
    before(:each) do
      @pin_hash = { 
        title: "Rails Wizard", 
        url: "http://railswizard.org", 
        slug: "rails-wizard", 
        text: "A fun and helpful Rails Resource",
        category_id: 2}
      post :create, pin: @pin_hash
      @pin = Pin.find_by_slug("rails-wizard")

      @updated_pin = {
        title: "updated",
        url: "updated", 
        slug: "updated", 
        text: "updated",
        category_id: 1}
    end

    after(:each) do
      @pin = Pin.find_by_slug("rails-wizard")
      if !@pin.nil?
        @pin.destroy
      end
    end

    it 'responds with a redirect following a PUT to /pins' do
      put :update, id: @pin.id, pin: @updated_pin
      @pin.reload
      expect(response.redirect?).to be(true)
      expect(response).to redirect_to("/pins/name-#{@pin.slug}")
    end

    it 'responds with success' do
      put :update, id: @pin.id, pin: @updated_pin
      expect(response.success?).to be(true)
    end

    it 'updates a pin' do
      put :update, id: @pin.id, pin: @updated_pin
      @pin.reload
      expect(assigns[:pin].slug).to eq(@updated_pin[:slug])
    end
  end
end