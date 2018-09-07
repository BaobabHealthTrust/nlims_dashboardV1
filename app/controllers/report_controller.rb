require "moh_report.rb"
class ReportController < ApplicationController
    
    def moh_report
        #loader for moh data reporting
        @doing_settings = false
    end

    def retrieve_data_moh_report
	
		year = params[:year]
        quarter = params[:quarter]
        indicator = params[:indicator]
		data =  {}
              
        data = MoHReport.get_statistics(indicator,year,quarter)
        
        
		render plain: data.to_json and return
    end    
end
