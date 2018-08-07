require "data_migration"
require "test_catelog"
class SettingController < ApplicationController
    def settings
        #load settings landing page
        @doing_settings = true
        @sample_types = TestCatelog.count_anomalises_specimen_type
        @test_types = TestCatelog.count_anomalises_test_types
        @measures = TestCatelog.count_anomalises_measures
    end

    def migrate_data 
        #load migration page
        @sample_types = TestCatelog.count_anomalises_specimen_type
        @test_types = TestCatelog.count_anomalises_test_types
        @measures = TestCatelog.count_anomalises_measures
    end

    def migrate
        year = params[:year]
        quarter = params[:quarter]
        DataMigration.load_slave_test_results
        #DataMigration.load_slave_tests
        #DataMigration.load_slave_orders
        #DataMigration.load_tests_results
        #DataMigration.load_tests
        #DataMigration.load_orders
        #DataMigration.check_files
        #DataMigration.createHeaders
        #DataMigration.load_data(year,quarter)
    end

end
