class CreateBoards < ActiveRecord::Migration
  def change
    create_table :boards do |t|
      t.string :name
      t.references :user, index: true

      t.timestamps null: false
    end
    add_foreign_key :boards, :users
    add_reference :pinnings, :board, index: true

    @users = User.all
    @users.each do |user|
      board = user.boards.create(name: "My Pins!")
      Pinning.where(user: user).each do |pinning|
        board.pinnings << pinning
      end
    end
  end
end
