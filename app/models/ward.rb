class Ward < ApplicationRecord
    
    def self.check_ward(type)
        rs = Site.find_by_sql("SELECT * FROM wards WHERE wards.name='#{type}'")
        if rs.length > 0
            return true
        else
            return false
        end
    end


    def self.get_ward_id(type)
        res = Ward.find_by_sql("SELECT wards.id AS tst_id FROM wards WHERE wards.name='#{type}'").first
        return res.tst_id
    end
end
