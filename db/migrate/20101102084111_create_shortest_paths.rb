class CreateShortestPaths < ActiveRecord::Migration
  def self.up
    create_table :shortest_paths do |t|
      t.column :path_id, :integer
      t.column :mode_id, :integer
      t.column :source_id, :bigint
      t.column :target_id, :bigint
      t.column :time_cost, :float
      t.column :length, :float

      t.timestamps
    end
  end

  def self.down
    drop_table :shortest_paths
  end
end
