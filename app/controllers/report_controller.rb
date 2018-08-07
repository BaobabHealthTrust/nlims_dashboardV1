require "moh_report.rb"
class ReportController < ApplicationController
    
    def moh_report
        #loader for moh data reporting
        @doing_settings = false
    end

    def retrieve_data_moh_report
		department = params[:department]
		year = params[:year]
		selected_quater = params[:quarter]
		level = params[:level]
        facility = params[:facility]
        data =  {}
        
        if level == "national"
            data = MoHReport.by_national(department, year, selected_quater)
           
        else
            data = MoHReport.by_facility(facility,department, year, selected_quater)
        end
        
		render plain: data.to_json and return
    end    
end
