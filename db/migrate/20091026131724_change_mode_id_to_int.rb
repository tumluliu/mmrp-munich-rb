class ChangeModeIdToInt < ActiveRecord::Migration
  def self.up
    add_column :modes, :mode_id_int, :integer, :limit => 4
    Mode.reset_column_information
    modes = Mode.find :all
    modes.each do |m|
      m.update_attribute(:mode_id_int, m.mode_id.to_i)
    end
    remove_column :modes, :mode_id
    rename_column :modes, :mode_id_int, :mode_id
    change_column :modes, :mode_id, :integer, :limit => 4, :null => false

    add_column :vertices, :mode_id_int, :integer, :limit => 4
    Vertex.reset_column_information
    vertices = Vertex.find :all
    vertices.each do |v|
      v.update_attribute(:mode_id_int, v.mode_id.to_i)
    end
    remove_column :vertices, :mode_id
    rename_column :vertices, :mode_id_int, :mode_id
    change_column :vertices, :mode_id, :integer, :limit => 4, :null => false

    add_column :edges, :mode_id_int, :integer, :limit => 4
    Edge.reset_column_information
    edges = Edge.find :all
    edges.each do |e|
      e.update_attribute(:mode_id_int, e.mode_id.to_i)
    end
    remove_column :edges, :mode_id
    rename_column :edges, :mode_id_int, :mode_id
    change_column :edges, :mode_id, :integer, :limit => 4, :null => false

    add_column :switch_points, :from_mode_id_int, :integer, :limit => 4
    add_column :switch_points, :to_mode_id_int, :integer, :limit => 4
    SwitchPoint.reset_column_information
    switch_points = SwitchPoint.find :all
    switch_points.each do |m|
      m.update_attribute(:from_mode_id_int, m.from_mode_id.to_i)
      m.update_attribute(:to_mode_id_int, m.to_mode_id.to_i)
    end
    remove_column :switch_points, :from_mode_id
    remove_column :switch_points, :to_mode_id
    rename_column :switch_points, :from_mode_id_int, :from_mode_id
    rename_column :switch_points, :to_mode_id_int, :to_mode_id
    change_column :switch_points, :from_mode_id, :integer, :limit => 4, :null => false
    change_column :switch_points, :to_mode_id, :integer, :limit => 4, :null => false
  end

  def self.down
    add_column :modes, :mode_id_double, :float
    Mode.reset_column_information
    modes = Mode.find :all
    modes.each do |m|
      m.update_attribute(:mode_id_double, m.mode_id.to_f)
      m.save!
    end
    remove_column :modes, :mode_id
    rename_column :modes, :mode_id_double, :mode_id

    add_column :vertices, :mode_id_double, :float
    Vertex.reset_column_information
    vertices = Vertex.find :all
    vertices.each do |v|
      v.update_attribute(:mode_id_double, v.mode_id.to_f)
      v.save!
    end
    remove_column :vertices, :mode_id
    rename_column :vertices, :mode_id_double, :mode_id

    add_column :edges, :mode_id_double, :float
    Edge.reset_column_information
    edges = Edge.find :all
    edges.each do |e|
      e.update_attribute(:mode_id_double, e.mode_id.to_f)
      e.save!
    end
    remove_column :edges, :mode_id
    rename_column :edges, :mode_id_double, :mode_id

    add_column :switch_points, :from_mode_id_double, :float
    add_column :switch_points, :to_mode_id_double, :float
    SwitchPoint.reset_column_information
    switch_points = SwitchPoint.find :all
    switch_points.each do |s|
      s.update_attribute(:from_mode_id_double, s.from_mode_id.to_f)
      s.update_attribute(:to_mode_id_double, s.to_mode_id.to_f)
      s.save!
    end
    remove_column :switch_points, :from_mode_id
    remove_column :switch_points, :to_mode_id
    rename_column :switch_points, :from_mode_id_double, :from_mode_id
    rename_column :switch_points, :to_mode_id_double, :to_mode_id
  end
end
