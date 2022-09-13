class CreateUserBooks < ActiveRecord::Migration[6.1]
  def change
    create_table :user_books do |t|
      t.references :user, null: false, foreign_key: true
      t.references :book, null: false, foreign_key: true
      t.boolean :is_read, default: false, null: false

      t.timestamps
      t.index [:user_id, :book_id], unique: true
    end
  end
end
