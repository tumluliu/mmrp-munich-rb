class CreateRoutingResultCaches < ActiveRecord::Migration
  def self.up
    create_table :routing_result_caches do |t|
      t.column :source, :bigint
      t.column :target, :bigint
      t.string :option_id
      t.text :result_list

      t.timestamps
    end
  end

  def self.down
    drop_table :routing_result_caches
  end
end
