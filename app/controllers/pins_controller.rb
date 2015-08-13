class PinsController < ApplicationController
  
  def index
    @pins = Pin.all
  end
  
  def show
    @pin = Pin.find(params[:id])
  end

  def show_by_name
  	@pin = Pin.find_by_slug(params[:slug])
  	render :show
  end

  def new
    @pin = Pin.new
  end

  def edit
    @pin = Pin.find(params[:id])
    render :edit
  end

  def update
    @pin = Pin.find(params[:id])
    @pin.update_attributes(pin_params)
    if @pin.valid?
      @pin.save
      redirect_to pin_path(@pin)
    else
      @errors = @pin.errors
      render :edit
    end
  end

  def create
    @pin = Pin.create(pin_params)
    #@pin.slug = @pin.make_slug(@pin.title)
    if @pin.valid?
      if @pin.category_id == "rails"
        @pin.category_id = 2
      elsif @pin.category_id == "ruby"
        @pin.category_id = 1
      else
        @pin.category_id = 3
      end
      @pin.save
      redirect_to pin_path(@pin)
    else
      @errors = @pin.errors
      render :new
    end
  end

=begin

  def make_slug(input)
      alpha = ["a","b","c","d","e","f","g","h","i","j","k","l","m","n","o","p","q","r","s","t","u","v","w","x","y","z","A","B","C","D","E","F","G","H","I","J","K","L","M","N","O","P","Q","R","S","T","U","V","W","X","Y","Z"]
      char_list = []
      input.each_char do |c|
        if c == " "
          c = "-"
          char_list.push c
        elsif alpha.include? c
          c.downcase!
          char_list.push c
        end
      end
      slug = char_list.join
      while slug.include?("--")
        slug = slug.gsub(/--/, "-")
      end
      return slug
    end

=end

  private

    def pin_params
      params.require(:pin).permit(:title, :url, :slug, :text, :category_id, :image)
    end

end