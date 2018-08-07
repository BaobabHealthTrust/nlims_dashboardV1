class Site < ApplicationRecord
    
    
    def self.check_site(type)
        rs = Site.find_by_sql("SELECT * FROM sites WHERE sites.name='#{type}'")
        if rs.length > 0
            return true
        else
            return false
        end
    end

end
