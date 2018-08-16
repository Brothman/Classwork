class CreateAlbums < ActiveRecord::Migration[5.2]
  def change
    create_table :albums do |t|
      t.string :title, null: false
      t.integer :year, null: false
      t.string :style, null: false, default: 'Studio'
      t.integer :band_id, null: false

      t.timestamps
    end
  end
end
