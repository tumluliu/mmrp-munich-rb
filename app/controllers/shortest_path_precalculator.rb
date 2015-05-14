# To change this template, choose Tools | Templates
# and open the template in the editor.
require 'mmspa4pg_ffi'

# move cursor to beginning of line
cr = "\r"
# ANSI escape code to clear line from cursor to end of line
clear = "\e[0K"

# reset lines
reset = cr + clear

#m = Mode.find_by_mode_id(1001)
ShortestPath.delete_all
PathComponent.delete_all

#if (Mmspa.ConnectDB("dbname = multimodal_munich user = user password = ********") == 1) then
#  puts "connect to database error"
#else
#  Mode.find(:all).each do |m|
#    puts "processing mode #{m.mode_name}"
#    vertices = Vertex.find_all_by_mode_id(m.mode_id)
#    mode_count = 1
#    public_mode_count = 0
#    routing_plan = Mmspa::RoutingPlan.new
#    routing_plan.mode_list[0] = m.mode_id
#    routing_plan.is_multimodal = false
#    routing_plan.description = ''
#    Mmspa.CreateRoutingPlan(mode_count, public_mode_count)
#    Mmspa.SetModeListItem(0, m.mode_id)
#    result = Mmspa::RoutingResult.new
#    result.planned_mode_list = routing_plan.mode_list
#    modes = routing_plan.mode_list
#    routing_plan.cost_factor = 'speed'
#    Mmspa.SetCostFactor(routing_plan.cost_factor)
#
#    #  u = Vertex.find_by_vertex_id(100101005282)
#    #  v = Vertex.find_by_vertex_id(100101006495)
#    puts "parsing the data..."
#    ################### Graph data reading ###################
#    start_time = Time.now
#    if Mmspa.Parse() == 1 then
#      puts "data_error"
#    else
#      puts "parsing successfully!"
#      end_time = Time.now
#      ellapsed = end_time - start_time
#      puts "time consumed by reading data: #{ellapsed.to_s} s"
#      k = 0
#      vertices.each do |u|
#        k = k + 1
#        print "#{reset}#{k}/#{vertices.length}"
#        $stdout.flush
#        #        puts "calculating route by MultimodalTwoQ..."
#        start_time = Time.now
#        ################### Shortest path calculation ###################
#        Mmspa.MultimodalTwoQ(u.vertex_id)
#        end_time = Time.now
#        ellapsed = end_time - start_time
#        #        puts "time consumed by route calculation: #{ellapsed.to_s} s"
#        paths_ptr = FFI::MemoryPointer.new(:pointer, 1)
#        vertices.each do |v|
#          if (u.vertex_id != v.vertex_id) then
#            paths_ptr = Mmspa.GetFinalPath(u.vertex_id, v.vertex_id)
#            if (paths_ptr.null?) then
#              #              puts "no path found"
#              result.is_existent = false
#            else
#              paths = []
#              vertex_count = 0
#              # get final paths from the marshaled pointer
#              mode_count.times do |i|
#                paths[i] = Mmspa::Path.new(paths_ptr.get_pointer(i * 4))
#                #                puts "#{modes[i]}"
#                #                puts "#{paths[i][:vertex_list_length]}"
#                result.paths_by_vertex_id[i] = []
#                result.paths_by_edge_id[i] = []
#                0.upto(paths[i][:vertex_list_length] - 1) do |j|
#                  result.paths_by_vertex_id[i][j] = paths[i][:vertex_list].get_int64(j * 8)
#                end
#                vertex_count += result.paths_by_vertex_id[i].length
#              end
#              if vertex_count == 0 then
#                result.is_existent = false
#              else
#                result.is_existent = true
#                0.upto(result.paths_by_vertex_id[0].length - 2) do |j|
#                  edge = Edge.find_by_from_id_and_to_id_and_mode_id(result.paths_by_vertex_id[0][j],
#                    result.paths_by_vertex_id[0][j + 1], modes[0])
#                  result.paths_by_edge_id[0][j] = edge.edge_id
#                end
#                result.length = Mmspa.GetFinalCost(v.vertex_id, 'distance')
#                #                puts "total distance: #{result.length}"
#                result.time = Mmspa.GetFinalCost(v.vertex_id, 'elapsed_time')
#                #                puts "total time: #{result.time}"
#                result.walking_length = Mmspa.GetFinalCost(v.vertex_id, 'walking_distance')
#                #                puts "total walking distance: #{result.walking_length}"
#                result.walking_time = Mmspa.GetFinalCost(v.vertex_id, 'walking_time')
#                #                puts "total walking time: #{result.walking_time}"
#              end
#              if (result.is_existent == true) then
#                #                puts "write the shortest path result to database"
#                #          write_to_db(result, u.vertex_id, v.vertex_id)
#                sp = ShortestPath.new
#                sp.mode_id = m.mode_id
#                sp.source_id = u.vertex_id
#                sp.target_id = v.vertex_id
#                sp.length = result.length
#                sp.time_cost = result.time
#                sp.save
#                sp.path_id = sp.id
#                sp.save
#                0.upto(result.paths_by_vertex_id[0].length - 1) do |i|
#                  path_com = PathComponent.new
#                  path_com.path_id = sp.path_id
#                  path_com.component_seq_id = i
#                  path_com.vertex_id = result.paths_by_vertex_id[0][i]
#                  if (i < result.paths_by_vertex_id[0].length - 1) then
#                    path_com.edge_id = result.paths_by_edge_id[0][i]
#                  else
#                    path_com.edge_id = nil
#                  end
#                  path_com.save
#                end
#              end
#              #              puts "Release final paths generated by mmspa4pg"
#              Mmspa.DisposePaths(paths_ptr)
#            end
#          end
#        end
#      end
#    end
#    puts "Release memory used by mmspa4pg"
#    Mmspa.Dispose()
#  end
#  print "#{reset}"     # clear current line
#  $stdout.flush
#  puts "done"
#  Mmspa.DisconnectDB()
#end
