class AllowMultipleCategories < ActiveRecord::Migration
  def self.up
    create_table 'book_types_books', :id => false do |t|
        t.column :book_type_id, :integer
        t.column :book_id, :integer
    end

    Book.all.each do |book|
      t = BookType.find( book.book_type_id )
      book.book_types << t
    end
  end

  def self.down
    drop_table 'book_types_books'
  end
end
