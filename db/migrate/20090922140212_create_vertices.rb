class CreateVertices < ActiveRecord::Migration
  def self.up
    create_table :vertices do |t|
      t.float :vertex_id
      t.float :x
      t.float :y
      t.integer :out_degree
      t.float :mode_id

      t.timestamps
    end
  end

  def self.down
    drop_table :vertices
  end
end
