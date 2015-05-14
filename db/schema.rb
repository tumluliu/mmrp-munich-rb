# This file is auto-generated from the current state of the database. Instead of editing this file, 
# please use the migrations feature of Active Record to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20101112145858) do

  create_table "car_parkings", :force => true do |t|
    t.column "link_id", :integer
    t.column "poi_id", :integer
    t.column "fac_type", :integer
    t.column "poi_name", :string
    t.column "poi_langcd", :string
    t.column "poi_nmtype", :string
    t.column "poi_st_num", :string
    t.column "st_name", :string
    t.column "st_langcd", :string
    t.column "poi_st_sd", :string
    t.column "acc_type", :string
    t.column "ph_number", :string
    t.column "chain_id", :integer
    t.column "nat_import", :string
    t.column "private", :string
    t.column "in_vicin", :string
    t.column "num_parent", :integer
    t.column "num_child", :integer
    t.column "percfrref", :integer
    t.column "van_city", :string
    t.column "act_addr", :string
    t.column "act_st_nam", :string
    t.column "act_st_num", :string
    t.column "act_admin", :string
    t.column "act_postal", :string
    t.column "um_id", :float
    t.column "the_geom", :point
  end

  add_index "car_parkings", ["the_geom"], :name => "index_car_parkings_on_the_geom", :spatial=> true 

  create_table "edges", :force => true do |t|
    t.column "length", :float
    t.column "speed_factor", :float
    t.column "created_at", :timestamp
    t.column "updated_at", :timestamp
    t.column "mode_id", :integer, :null => false
    t.column "from_id", :integer, :null => false
    t.column "to_id", :integer, :null => false
    t.column "edge_id", :integer, :null => false
  end

  add_index "edges", ["edge_id"], :name => "edge_id_idx"
  add_index "edges", ["mode_id"], :name => "edge_mode_idx"
  add_index "edges", ["from_id"], :name => "from_idx"
  add_index "edges", ["to_id"], :name => "to_idx"

  create_table "modes", :force => true do |t|
    t.column "mode_name", :string
    t.column "created_at", :timestamp
    t.column "updated_at", :timestamp
    t.column "mode_id", :integer, :null => false
  end

  add_index "modes", ["mode_id"], :name => "mode_id_idx", :unique => true

  create_table "park_and_rides", :force => true do |t|
    t.column "link_id", :integer
    t.column "poi_id", :integer
    t.column "fac_type", :integer
    t.column "poi_name", :string
    t.column "poi_langcd", :string
    t.column "poi_nmtype", :string
    t.column "poi_st_num", :string
    t.column "st_name", :string
    t.column "st_langcd", :string
    t.column "poi_st_sd", :string
    t.column "acc_type", :string
    t.column "ph_number", :string
    t.column "chain_id", :integer
    t.column "nat_import", :string
    t.column "private", :string
    t.column "in_vicin", :string
    t.column "num_parent", :integer
    t.column "num_child", :integer
    t.column "percfrref", :integer
    t.column "van_city", :string
    t.column "act_addr", :string
    t.column "act_st_nam", :string
    t.column "act_st_num", :string
    t.column "act_admin", :string
    t.column "act_postal", :string
    t.column "um_id", :float
    t.column "um_name", :string
    t.column "um_cat", :string
    t.column "um_type", :integer
    t.column "nvt_region", :string
    t.column "the_geom", :point
  end

  add_index "park_and_rides", ["the_geom"], :name => "index_park_and_rides_on_the_geom", :spatial=> true 

  create_table "path_components", :force => true do |t|
    t.column "path_id", :integer
    t.column "component_seq_id", :integer
    t.column "vertex_id", :integer
    t.column "edge_id", :integer
    t.column "created_at", :timestamp
    t.column "updated_at", :timestamp
  end

  create_table "public_transit_lines", :force => true do |t|
    t.column "transit_line_id", :integer
    t.column "mode_id", :integer
    t.column "abbr", :string
    t.column "from_station_id", :integer
    t.column "to_station_id", :integer
    t.column "created_at", :timestamp
    t.column "updated_at", :timestamp
  end

  create_table "public_transit_schedules", :force => true do |t|
    t.column "schedule_id", :integer
    t.column "station_id", :integer
    t.column "transit_line_id", :integer
    t.column "direction_station_id", :integer
    t.column "dest_station_id", :integer
    t.column "weekday", :integer
    t.column "departure_time_hour", :integer
    t.column "departure_time_min", :integer
    t.column "holiday_schedule", :boolean
    t.column "created_at", :timestamp
    t.column "updated_at", :timestamp
  end

  create_table "routing_result_caches", :force => true do |t|
    t.column "source", :integer
    t.column "target", :integer
    t.column "option_id", :string
    t.column "result_list", :text
    t.column "created_at", :timestamp
    t.column "updated_at", :timestamp
  end

  create_table "routingresultcaches", :force => true do |t|
    t.column "source", :integer
    t.column "target", :integer
    t.column "option_id", :string
    t.column "result", :text
    t.column "created_at", :timestamp
    t.column "updated_at", :timestamp
  end

  create_table "shortest_paths", :force => true do |t|
    t.column "path_id", :integer
    t.column "mode_id", :integer
    t.column "source_id", :integer
    t.column "target_id", :integer
    t.column "time_cost", :float
    t.column "length", :float
    t.column "created_at", :timestamp
    t.column "updated_at", :timestamp
  end

  create_table "street_junctions", :force => true do |t|
    t.column "x", :float
    t.column "y", :float
    t.column "nodeid", :integer
    t.column "valence", :integer
    t.column "the_geom", :point
  end

  add_index "street_junctions", ["the_geom"], :name => "index_street_junctions_on_the_geom", :spatial=> true 

  create_table "street_lines", :force => true do |t|
    t.column "um_id", :float
    t.column "um_name", :string
    t.column "um_type", :integer
    t.column "matchtyp", :string
    t.column "shopping", :string
    t.column "link_id", :float
    t.column "func_class", :string
    t.column "speed_cat", :string
    t.column "divider", :string
    t.column "dir_travel", :string
    t.column "ar_auto", :string
    t.column "ar_pedest", :string
    t.column "bridge", :string
    t.column "tunnel", :string
    t.column "l_postcode", :string
    t.column "r_postcode", :string
    t.column "cond_type", :integer
    t.column "cond_val1", :string
    t.column "cond_id", :float
    t.column "man_linkid", :float
    t.column "seq_number", :integer
    t.column "ob", :string
    t.column "oba", :integer
    t.column "refb", :string
    t.column "refa", :string
    t.column "shape_leng", :float
    t.column "enabled", :integer
    t.column "fnodeid", :integer
    t.column "tnodeid", :integer
    t.column "overlapobj", :integer
    t.column "snodesobj", :integer
    t.column "zerofeat", :integer
    t.column "the_geom", :multi_line_string
  end

  add_index "street_lines", ["the_geom"], :name => "index_street_lines_on_the_geom", :spatial=> true 

  create_table "suburban_junctions", :force => true do |t|
    t.column "x", :float
    t.column "y", :float
    t.column "nodeid", :integer
    t.column "valence", :integer
    t.column "the_geom", :point
  end

  add_index "suburban_junctions", ["the_geom"], :name => "index_suburban_junctions_on_the_geom", :spatial=> true 

  create_table "suburban_lines", :force => true do |t|
    t.column "um_id", :float
    t.column "um_name", :string
    t.column "um_type", :integer
    t.column "timespan", :integer
    t.column "label", :string
    t.column "ob", :string
    t.column "oba", :integer
    t.column "bkt", :integer
    t.column "tr_type", :string
    t.column "et_fnode", :float
    t.column "et_tnode", :float
    t.column "shape_leng", :float
    t.column "enabled", :integer
    t.column "fnodeid", :integer
    t.column "tnodeid", :integer
    t.column "overlapobj", :integer
    t.column "snodesobj", :integer
    t.column "zerofeat", :integer
    t.column "the_geom", :multi_line_string
  end

  add_index "suburban_lines", ["the_geom"], :name => "index_suburban_lines_on_the_geom", :spatial=> true 

  create_table "suburban_stations", :force => true do |t|
    t.column "um_id", :float
    t.column "um_name", :string
    t.column "um_type", :integer
    t.column "tr_type", :string
    t.column "link_id", :integer
    t.column "fac_type", :integer
    t.column "ob", :string
    t.column "oba", :integer
    t.column "bfk", :integer
    t.column "type_id", :integer
    t.column "the_geom", :point
  end

  add_index "suburban_stations", ["the_geom"], :name => "index_suburban_stations_on_the_geom", :spatial=> true 

  create_table "switch_points", :force => true do |t|
    t.column "cost", :float
    t.column "is_available", :boolean
    t.column "created_at", :timestamp
    t.column "updated_at", :timestamp
    t.column "from_mode_id", :integer, :null => false
    t.column "to_mode_id", :integer, :null => false
    t.column "type_id", :integer, :null => false
    t.column "from_vertex_id", :integer, :null => false
    t.column "to_vertex_id", :integer, :null => false
    t.column "switch_point_id", :integer
    t.column "ref_poi_id", :integer
  end

  add_index "switch_points", ["from_mode_id", "to_mode_id"], :name => "mode_id_pair_idx"
  add_index "switch_points", ["type_id"], :name => "type_id_idx"

  create_table "switch_types", :force => true do |t|
    t.column "type_name", :string
    t.column "created_at", :timestamp
    t.column "updated_at", :timestamp
    t.column "type_id", :integer, :null => false
  end

  create_table "tram_junctions", :force => true do |t|
    t.column "x", :float
    t.column "y", :float
    t.column "nodeid", :integer
    t.column "valence", :integer
    t.column "the_geom", :point
  end

  add_index "tram_junctions", ["the_geom"], :name => "index_tram_junctions_on_the_geom", :spatial=> true 

  create_table "tram_lines", :force => true do |t|
    t.column "um_id", :float
    t.column "um_name", :string
    t.column "um_type", :integer
    t.column "timespan", :integer
    t.column "label", :string
    t.column "ob", :string
    t.column "oba", :integer
    t.column "bkt", :integer
    t.column "tr_type", :string
    t.column "et_fnode", :float
    t.column "et_tnode", :float
    t.column "shape_leng", :float
    t.column "enabled", :integer
    t.column "fnodeid", :integer
    t.column "tnodeid", :integer
    t.column "overlapobj", :integer
    t.column "snodesobj", :integer
    t.column "zerofeat", :integer
    t.column "the_geom", :multi_line_string
  end

  add_index "tram_lines", ["the_geom"], :name => "index_tram_lines_on_the_geom", :spatial=> true 

  create_table "tram_stations", :force => true do |t|
    t.column "um_id", :float
    t.column "um_name", :string
    t.column "um_type", :integer
    t.column "tr_type", :string
    t.column "link_id", :integer
    t.column "fac_type", :integer
    t.column "ob", :string
    t.column "oba", :integer
    t.column "bfk", :integer
    t.column "type_id", :integer
    t.column "the_geom", :point
  end

  add_index "tram_stations", ["the_geom"], :name => "index_tram_stations_on_the_geom", :spatial=> true 

  create_table "underground_junctions", :force => true do |t|
    t.column "x", :float
    t.column "y", :float
    t.column "nodeid", :integer
    t.column "valence", :integer
    t.column "the_geom", :point
  end

  add_index "underground_junctions", ["the_geom"], :name => "index_underground_junctions_on_the_geom", :spatial=> true 

  create_table "underground_lines", :force => true do |t|
    t.column "um_id", :float
    t.column "um_name", :string
    t.column "um_type", :integer
    t.column "timespan", :integer
    t.column "label", :string
    t.column "ob", :string
    t.column "oba", :integer
    t.column "bkt", :integer
    t.column "tr_type", :string
    t.column "et_fnode", :float
    t.column "et_tnode", :float
    t.column "shape_leng", :float
    t.column "enabled", :integer
    t.column "fnodeid", :integer
    t.column "tnodeid", :integer
    t.column "overlapobj", :integer
    t.column "snodesobj", :integer
    t.column "zerofeat", :integer
    t.column "the_geom", :multi_line_string
  end

  add_index "underground_lines", ["the_geom"], :name => "index_underground_lines_on_the_geom", :spatial=> true 

  create_table "underground_stations", :force => true do |t|
    t.column "um_id", :float
    t.column "um_name", :string
    t.column "um_type", :integer
    t.column "tr_type", :string
    t.column "link_id", :integer
    t.column "fac_type", :integer
    t.column "ob", :string
    t.column "oba", :integer
    t.column "bfk", :integer
    t.column "type_id", :integer
    t.column "the_geom", :point
  end

  add_index "underground_stations", ["the_geom"], :name => "index_underground_stations_on_the_geom", :spatial=> true 

  create_table "vertices", :force => true do |t|
    t.column "out_degree", :integer
    t.column "created_at", :timestamp
    t.column "updated_at", :timestamp
    t.column "first_edge", :float
    t.column "vertex_id", :integer, :null => false
    t.column "mode_id", :integer, :null => false
    t.column "x", :float
    t.column "y", :float
  end

  add_index "vertices", ["vertex_id"], :name => "vertex_id_idx", :unique => true
  add_index "vertices", ["mode_id"], :name => "vertex_mode_idx"

end
