class AddCommentToAuthor < ActiveRecord::Migration
  def self.up
    add_column :authors, :comment, :text
  end

  def self.down
    remove_column :authors, :comment
  end
end
