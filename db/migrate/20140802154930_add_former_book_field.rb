class AddFormerBookField < ActiveRecord::Migration
  def self.up
    add_column :books, :former_book, :boolean
  end

  def self.down
    remove_column :books, :former_book
  end
end
