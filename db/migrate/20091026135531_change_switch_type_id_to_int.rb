class ChangeSwitchTypeIdToInt < ActiveRecord::Migration
  def self.up
    add_column :switch_types, :type_id_int, :integer, :limit => 4
    SwitchType.reset_column_information
    switch_types = SwitchType.find :all
    switch_types.each do |st|
      st.update_attribute(:type_id_int, st.type_id.to_i)
    end
    remove_column :switch_types, :type_id
    rename_column :switch_types, :type_id_int, :type_id
    change_column :switch_types, :type_id, :integer, :limit => 4, :null => false

    add_column :switch_points, :type_id_int, :integer, :limit => 4
    SwitchPoint.reset_column_information
    switch_points = SwitchPoint.find :all
    switch_points.each do |sp|
      sp.update_attribute(:type_id_int, sp.type_id.to_i)
    end
    remove_column :switch_points, :type_id
    rename_column :switch_points, :type_id_int, :type_id
    change_column :switch_points, :type_id, :integer, :limit => 4, :null => false
  end

  def self.down
    add_column :switch_types, :type_id_double, :float
    SwitchType.reset_column_information
    switch_types = SwitchType.find :all
    switch_types.each do |st|
      st.update_attribute(:type_id_double, st.type_id.to_f)
      st.save!
    end
    remove_column :switch_types, :type_id
    rename_column :switch_types, :type_id_double, :type_id

    add_column :switch_points, :type_id_double, :float
    SwitchPoint.reset_column_information
    switch_points = SwitchPoint.find :all
    switch_points.each do |sp|
      sp.update_attribute(:type_id_double, sp.mode_id.to_f)
      sp.save!
    end
    remove_column :switch_points, :type_id
    rename_column :switch_points, :type_id_double, :type_id
  end
end
