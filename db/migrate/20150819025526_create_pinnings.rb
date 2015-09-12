class CreatePinnings < ActiveRecord::Migration
  def change
    create_table :pinnings do |t|
      t.references :user, index: true
      t.references :pin, index: true
      t.timestamps null: true
    end
    add_foreign_key :pinnings, :users
    add_foreign_key :pinnings, :pins

    Pin.where(user_id: !nil).each do |pin|
      #user = pin.user
    	if pin.user.present?
    		puts "user present: #{user.id}"
    		pin.pinnings.create(user_id: pin.user_id, pin_id: pin.id)
    	end
    end
  end
end
