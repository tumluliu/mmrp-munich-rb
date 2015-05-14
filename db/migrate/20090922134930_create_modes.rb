class CreateModes < ActiveRecord::Migration
  def self.up
    create_table :modes do |t|
      t.float :mode_id
      t.string :mode_name

      t.timestamps
    end
  end

  def self.down
    drop_table :modes
  end
end
