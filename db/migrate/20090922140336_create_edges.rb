class CreateEdges < ActiveRecord::Migration
  def self.up
    create_table :edges do |t|
      t.float :edge_id
      t.float :from_id
      t.float :to_id
      t.float :length
      t.float :speed_factor
      t.float :mode_id

      t.timestamps
    end
  end

  def self.down
    drop_table :edges
  end
end
