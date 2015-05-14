class AddColumnXyBackToVertices < ActiveRecord::Migration
  def self.up
    add_column :vertices, :x, :float
    add_column :vertices, :y, :float
  end

  def self.down
    remove_column :vertices, :x
    remove_column :vertices, :y
  end
end
