class CreateBooks < ActiveRecord::Migration
  def self.up
    create_table :books do |t|
      t.string :title
      t.string :subtitle
      t.string :comment
      t.integer :language_id
      t.integer :owner_id
      t.integer :book_type_id
      t.integer :location_id
      t.integer :column_nr
      t.integer :row_nr

      t.timestamps
    end
  end

  def self.down
    drop_table :books
  end
end
