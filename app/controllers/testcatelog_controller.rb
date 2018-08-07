require "test_catelog.rb"
class TestcatelogController < ApplicationController

    def specimen_types
        @specimen_type = TestCatelog.retrieve_specimen_types
        @doing_settings = false
    end

    def test_types
        @test_type = TestCatelog.retrieve_test_types
       
        @doing_settings = false
    end

    def test_Categories
        cat = TestCatelog.retrieve_test_Categories
        render plain: cat.to_json and return
    end

    def specimen_test_types
        @test_types = TestCatelog.retrieve_specimen_test_types(params[:specimen_type])
        @specimen_type = params[:specimen_type]
        @doing_settings = false
    end

    def unresolved_specimen
        @data = TestCatelog.pull_unresolved_specimen
        @sample_types = TestCatelog.count_anomalises_specimen_type
        @test_types = TestCatelog.count_anomalises_test_types
        @measures = TestCatelog.count_anomalises_measures
    end


    def unresolved_test_types
        @data = TestCatelog.pull_unresolved_test_types
        @sample_types = TestCatelog.count_anomalises_specimen_type
        @test_types = TestCatelog.count_anomalises_test_types
        @measures = TestCatelog.count_anomalises_measures
    end


    def unresolved_measures
        @data = TestCatelog.pull_unresolved_measures
        @sample_types = TestCatelog.count_anomalises_specimen_type
        @test_types = TestCatelog.count_anomalises_test_types
        @measures = TestCatelog.count_anomalises_measures
    end

    def resolve_specimen
        @sample_type = params[:sample_name]
        @sample_types = TestCatelog.count_anomalises_specimen_type
        @test_types = TestCatelog.count_anomalises_test_types
        @measures = TestCatelog.count_anomalises_measures

        @data = TestCatelog.capture_possible_matches(@sample_type)

    end

    def resolve_test_types
        @test_type = params[:test_type]
        @sample_types = TestCatelog.count_anomalises_specimen_type
        @test_types = TestCatelog.count_anomalises_test_types
        @measures = TestCatelog.count_anomalises_measures

        @data = TestCatelog.capture_possible_test_type_matches(@test_type)
    end

    def add_resolved
        category = params[:categorty] rescue nil
        tat = params[:tat] rescue nil
        short_name = params[:short_name] rescue nil

        TestCatelog.add_resolved(params[:type],params[:value],category,tat,short_name)
        render plain: "yes" and return
    end

    def merge_resolved
        TestCatelog.merge_resolved(params[:type],params[:merge_value],params[:actual_value])
        render plain: "yes" and return
    end
    
end
