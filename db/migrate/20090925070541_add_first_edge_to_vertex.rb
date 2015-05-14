class AddFirstEdgeToVertex < ActiveRecord::Migration
  def self.up
    add_column :vertices, :first_edge, :float
  end

  def self.down
    remove_column :vertices, :first_edge
  end
end
