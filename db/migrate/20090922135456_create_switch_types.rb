class CreateSwitchTypes < ActiveRecord::Migration
  def self.up
    create_table :switch_types do |t|
      t.float :type_id
      t.string :type_name

      t.timestamps
    end
  end

  def self.down
    drop_table :switch_types
  end
end
