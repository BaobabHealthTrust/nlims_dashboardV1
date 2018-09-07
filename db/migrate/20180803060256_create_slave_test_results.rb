class CreateSlaveTestResults < ActiveRecord::Migration[5.2]
  def change
    create_table :slave_test_results, {:id => false}  do |t|

     t.string :id, primary_key: false
     t.string :test_type
     t.string :measure
     t.string :measure_resolved_to
     t.string(20000) :measure_value
     t.string :resolving_status
    end
  end
end
