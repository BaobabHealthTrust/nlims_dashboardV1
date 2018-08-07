class SpecimenStatus < ApplicationRecord

    def self.check_specimen_status(type)
        rs = SpecimenStatus.find_by_sql("SELECT * FROM specimen_statuses WHERE specimen_statuses.name='#{type}'")
        if rs.length > 0
            return true
        else
            return false
        end
    end

    def self.get_specimen_status_id(type)
        res = SpecimenStatus.find_by_sql("SELECT specimen_statuses.id AS tst_id FROM specimen_statuses WHERE specimen_statuses.name='#{type}'").first
        return res.tst_id
    end

end
