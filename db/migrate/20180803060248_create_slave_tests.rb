class CreateSlaveTests < ActiveRecord::Migration[5.2]
  def change
    create_table :slave_tests, {:id => false}  do |t|

    t.string :id, primary_key: false
    t.string :test_type
     t.string :test_type_resolved_to
     t.string :test_status
     t.string :test_status_resolved_to
     t.string :remarks
     t.string :date_time_started
     t.string :date_time_completed
     t.string :resolving_status
    
    end
  end
end
