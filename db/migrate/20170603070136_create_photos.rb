class CreatePhotos < ActiveRecord::Migration[5.0]
  def change
    create_table :photos do |t|
      t.text :image_data
      t.belongs_to :admin, foreign_key: true
      t.belongs_to :album, foreign_key: true

      t.timestamps
    end
  end
end
