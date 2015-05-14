class CreatePublicTransitSchedules < ActiveRecord::Migration
  def self.up
    create_table :public_transit_schedules do |t|
      t.integer :schedule_id, :limit => 8
      t.integer :station_id,  :limit => 8
      t.integer :transit_line_id,     :limit => 8
      t.integer :direction_station_id,  :limit => 8
      t.integer :dest_station_id, :limit => 8
      t.integer :weekday
      t.integer :departure_time_hour
      t.integer :departure_time_min
      t.boolean :holiday_schedule
      
      t.timestamps
    end
  end

  def self.down
    drop_table :public_transit_schedules
  end
end
