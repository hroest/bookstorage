class CreateLocations < ActiveRecord::Migration
  def self.up
    create_table :locations do |t|
      t.string :apartment
      t.string :room
      t.string :shelf
      # t.string :column
      # t.string :height
      t.string :comment

      t.timestamps
    end
  end

  def self.down
    drop_table :locations
  end
end
