class CreateTinymceAssets < ActiveRecord::Migration[5.0]
  def change
    create_table :tinymce_assets do |t|
      t.text :image_data

      t.timestamps
    end
  end
end
