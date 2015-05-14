class AddSwitchpointidAndRefpoiidToSwitchPoints < ActiveRecord::Migration
  def self.up
    add_column :switch_points, :switch_point_id, :bigint
    add_column :switch_points, :ref_poi_id, :bigint
  end

  def self.down
    remove_column :switch_points, :switch_point_id
    remove_column :switch_points, :ref_poi_id
  end
end
