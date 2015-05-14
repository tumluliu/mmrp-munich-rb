class ChangeForigenVertexIdToBigint < ActiveRecord::Migration
  def self.up
    add_column :edges, :from_id_int, :bigint
    add_column :edges, :to_id_int, :bigint
    Edge.reset_column_information
    edges = Edge.find :all
    edges.each do |e|
      e.update_attribute(:from_id_int, e.from_id.to_i)
      e.update_attribute(:to_id_int, e.to_id.to_i)
    end
    remove_column :edges, :from_id
    remove_column :edges, :to_id
    rename_column :edges, :from_id_int, :from_id
    rename_column :edges, :to_id_int, :to_id
    change_column :edges, :from_id, :bigint, :null => false
    change_column :edges, :to_id, :bigint, :null => false

    add_column :switch_points, :from_vertex_id_int, :bigint
    add_column :switch_points, :to_vertex_id_int, :bigint
    SwitchPoint.reset_column_information
    switch_points = SwitchPoint.find :all
    switch_points.each do |s|
      s.update_attribute(:from_vertex_id_int, s.from_vertex_id.to_i)
      s.update_attribute(:to_vertex_id_int, s.to_vertex_id.to_i)
    end
    remove_column :switch_points, :from_vertex_id
    remove_column :switch_points, :to_vertex_id
    rename_column :switch_points, :from_vertex_id_int, :from_vertex_id
    rename_column :switch_points, :to_vertex_id_int, :to_vertex_id
    change_column :switch_points, :from_vertex_id, :bigint, :null => false
    change_column :switch_points, :to_vertex_id, :bigint, :null => false
  end

  def self.down
    add_column :edges, :from_id_double, :float
    add_column :edges, :to_id_double, :float
    Edge.reset_column_information
    edges = Edge.find :all
    edges.each do |v|
      v.update_attribute(:from_id_double, v.from_id.to_f)
      v.update_attribute(:to_id_double, v.to_id.to_f)
      v.save!
    end
    remove_column :edges, :from_id
    remove_column :edges, :to_id
    rename_column :edges, :from_id_double, :from_id
    rename_column :edges, :to_id_double, :to_id

    add_column :switch_points, :from_vertex_id_double, :float
    add_column :switch_points, :to_vertex_id_double, :float
    SwitchPoint.reset_column_information
    switch_points = SwitchPoint.find :all
    switch_points.each do |s|
      s.update_attribute(:from_vertex_id_double, s.from_vertex_id.to_f)
      s.update_attribute(:to_vertex_id_double, s.to_vertex_id.to_f)
      s.save!
    end
    remove_column :switch_points, :from_vertex_id
    remove_column :switch_points, :to_vertex_id
    rename_column :switch_points, :from_vertex_id_double, :from_vertex_id
    rename_column :switch_points, :to_vertex_id_double, :to_vertex_id
  end
end
