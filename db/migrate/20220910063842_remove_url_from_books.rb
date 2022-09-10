class RemoveUrlFromBooks < ActiveRecord::Migration[6.1]
  def change
    remove_column :books, :url, :string
  end
end
