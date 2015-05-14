class CreateSwitchPoints < ActiveRecord::Migration
  def self.up
    create_table :switch_points do |t|
      t.float :type_id
      t.float :from_mode_id
      t.float :to_mode_id
      t.float :from_vertex_id
      t.float :to_vertex_id
      t.float :cost
      t.boolean :is_available

      t.timestamps
    end
  end

  def self.down
    drop_table :switch_points
  end
end
