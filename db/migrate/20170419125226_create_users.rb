class CreateUsers < ActiveRecord::Migration[5.0]
  def change
    create_table :users do |t|
      t.string :first_name
      t.string :last_name
      t.string :email, unique: true
      t.boolean :admin
      t.boolean :attendee
      t.timestamps
    end
  end
end