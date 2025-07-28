class CreateRoomMemberships < ActiveRecord::Migration[7.2]
  def change
    create_table :room_memberships do |t|
      t.references :user, null: false, foreign_key: true
      t.references :room, null: false, foreign_key: true

      t.timestamps
    end
  end
end
