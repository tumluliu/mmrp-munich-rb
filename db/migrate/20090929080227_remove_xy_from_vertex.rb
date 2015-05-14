class RemoveXyFromVertex < ActiveRecord::Migration
  def self.up
    remove_column :vertices, :x
    remove_column :vertices, :y
  end

  def self.down
    add_column :vertices, :y, :float
    add_column :vertices, :x, :float
  end
end
