class CreateSlaveOrders < ActiveRecord::Migration[5.2]
  def change
    create_table :slave_orders, {:id => false} do |t|

        t.string :id, primary_key: true
       	t.string :sending_facility
      	t.string :sending_facility_resolved_to
      	t.string :receiving_facility
      	t.string :receiving_facility_resolved_to
      	t.string :sample_type
      	t.string :sample_type_resolved_to
      	t.string :who_order_first_name
      	t.string :who_order_last_name
      	t.string :who_order_id
        t.string :who_order_phone
        t.string :art_start_date
        t.string :dispatched_date
        t.string :date_drawn
        t.string :date_received
        t.string :date
        t.string :district
        t.string :order_location
        t.string :order_location_resolved_to
        t.string :priority
        t.string :order_status
        t.string :order_status_resolved_to
        t.string :order_resolve_status
      
    end
  end
end
