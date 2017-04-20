class CreateSeminars < ActiveRecord::Migration[5.0]
  def change
    create_table :seminars do |t|
      t.string :title
      t.text   :description
      t.string :author
      t.string :company
      t.decimal :price,precision: 12 , scale: 3 
      t.date :start_date
      t.date :end_date
      t.references :user, index: true
      t.references :catagory,index: true
      t.timestamps
    end
  end
end
