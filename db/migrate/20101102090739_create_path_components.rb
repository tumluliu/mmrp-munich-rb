class CreatePathComponents < ActiveRecord::Migration
  def self.up
    create_table :path_components do |t|
      t.column :path_id, :integer
      t.column :component_seq_id, :integer
      t.column :vertex_id, :bigint
      t.column :edge_id, :bigint

      t.timestamps
    end
  end

  def self.down
    drop_table :path_components
  end
end
