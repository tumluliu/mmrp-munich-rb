class ChangeEdgeIdToBigint < ActiveRecord::Migration
  def self.up
    add_column :edges, :edge_id_int, :bigint
    Edge.reset_column_information
    edges = Edge.find :all
    edges.each do |e|
      e.update_attribute(:edge_id_int, e.edge_id.to_i)
    end
    remove_column :edges, :edge_id
    rename_column :edges, :edge_id_int, :edge_id
    change_column :edges, :edge_id, :bigint, :null => false
  end

  def self.down
    add_column :edges, :edge_id_double, :float
    Vertex.reset_column_information
    edges = Edge.find :all
    edges.each do |e|
      e.update_attribute(:edge_id_double, e.edge_id.to_f)
      e.save!
    end
    remove_column :edges, :edge_id
    rename_column :edges, :edge_id_double, :edge_id
  end
end
