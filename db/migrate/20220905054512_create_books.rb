class CreateBooks < ActiveRecord::Migration[6.1]
  def change
    create_table :books do |t|
      t.string :title
      t.string :author
      t.string :isbn, null: false
      t.string :item_url
      t.string :image_url
      t.boolean :is_read, null: false, default: false

      t.timestamps
    end
  end
end
