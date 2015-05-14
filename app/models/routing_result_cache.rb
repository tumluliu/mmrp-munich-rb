class RoutingResultCache < ActiveRecord::Base
  serialize :result_list, Array
end
