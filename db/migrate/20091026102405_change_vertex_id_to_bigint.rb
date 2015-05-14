class ChangeVertexIdToBigint < ActiveRecord::Migration
  def self.up
    add_column :vertices, :vertex_id_int, :bigint
    Vertex.reset_column_information
    vertices = Vertex.find :all
    vertices.each do |v|
      v.update_attribute(:vertex_id_int, v.vertex_id.to_i)
    end
    remove_column :vertices, :vertex_id
    rename_column :vertices, :vertex_id_int, :vertex_id
    change_column :vertices, :vertex_id, :bigint, :null => false
  end

  def self.down
    add_column :vertices, :vertex_id_double, :float
    Vertex.reset_column_information
    vertices = Vertex.find :all
    vertices.each do |v|
      v.update_attribute(:vertex_id_double, v.vertex_id.to_f)
      v.save!
    end
    remove_column :vertices, :vertex_id
    rename_column :vertices, :vertex_id_double, :vertex_id
  end
end
