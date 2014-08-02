class RemoveBookType < ActiveRecord::Migration
  def self.up
    remove_column :books, :book_type_id
  end

  def self.down
    add_column :books, :book_type_id, :integer
  end
end
