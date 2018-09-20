require "moh_report.rb"
require "landing_page_data.rb"
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
    
    
    def retrieve_landing_page_data
        option = params[:option];
        LandingPageData.get_period
        LandingPageData.setter(option)
        res = LandingPageData.get_verified_tests
        render :plain => res.to_json and return
    end
    
    def retrieve_total_orders
        option = params[:option];
        LandingPageData.get_period
        LandingPageData.setter(option)
        res = LandingPageData.retrieve_total_orders
        render :plain => res.to_json and return
    end

    def retrieve_completed_tests
        option = params[:option];
        LandingPageData.get_period
        LandingPageData.setter(option)
        res = LandingPageData.get_completed_tests
        render :plain => res.to_json and return
    end

    def retrieve_pending_tests
        option = params[:option];
        LandingPageData.get_period
        LandingPageData.setter(option)
        res = LandingPageData.retrieve_pending_tests
        render :plain => res.to_json and return
    end


    def retrieve_rejected_tests
        option = params[:option];
        LandingPageData.get_period
        LandingPageData.setter(option)
        res = LandingPageData.retrieve_rejected_tests
        render :plain => res.to_json and return
    end

    def retrieve_site_sync_updats
        site = params[:option]
        LandingPageData.setter(site)
        LandingPageData.get_period
        res = LandingPageData.retrieve_site_sync_updates
        render :plain => res.to_json and return
    end

    def retrieve_lab_departments_tests
        site = params[:option]
        LandingPageData.setter(site)
        LandingPageData.get_period
        res = LandingPageData.retrieve_lab_departments_tests
        render :plain => res.to_json and return
    end 
end
