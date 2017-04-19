class AddImageToPhotos < ActiveRecord::Migration[5.0]
  def self.up
    change_table :photos do |t|
      t.attachment :image
    end
  end
end
