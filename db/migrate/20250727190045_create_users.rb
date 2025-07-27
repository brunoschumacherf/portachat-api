# db/migrate/YYYYMMDDHHMMSS_create_users.rb
class CreateUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :users do |t|
      t.string :name, null: false
      t.string :email, null: false
      t.string :password_digest, null: false
      t.integer :access_level, default: 0, null: false # 0: member, 1: admin
      t.integer :status, default: 0, null: false       # 0: active, 1: inactive

      t.timestamps
    end
    add_index :users, :email, unique: true
  end
end
