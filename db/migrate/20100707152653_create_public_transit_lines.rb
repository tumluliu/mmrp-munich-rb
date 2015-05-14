class CreatePublicTransitLines < ActiveRecord::Migration
  def self.up
    create_table :public_transit_lines do |t|
      t.integer :transit_line_id,  :limit => 8
      t.integer :mode_id
      t.string  :abbr
      t.integer :from_station_id, :limit => 8
      t.integer :to_station_id, :limit => 8

      t.timestamps
    end
  end

  def self.down
    drop_table :public_transit_lines
  end
end
