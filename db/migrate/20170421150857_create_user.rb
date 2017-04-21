class CreateUser < ActiveRecord::Migration[5.0]
  def change
    create_table :users do |t|
      t.string :first_name
      t.string :last_name
      t.string :email, unique: true
      t.boolean :admin, default: false
      t.boolean :organizer, default: false
      t.timestamps
    end
  end
end
